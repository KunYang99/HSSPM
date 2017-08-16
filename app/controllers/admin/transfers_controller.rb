class Admin::TransfersController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  require 'csv'

  def index
    @ops = ['Sample', 'Transfer To']
    
    @transfers = Transfer.paginate(:page => params[:page], :per_page => 10).order('updated_at DESC')
  end
  
  def search_results
    @ops = ['Sample', 'Transfer To']

    if params['key'] == 'Sample'
      @transfers = Transfer.joins(:human_sample).where("human_samples.accession LIKE ?", "%%#{params['value']}%%")
    else
      @transfers = Transfer.where("trans_to LIKE ?", "%%#{params['value']}%%")
    end
  end

  def new
    @transfer = Transfer.new
    @id = params[:human_sample_id]
  end

  def create
    @transfer = Transfer.new(transfer_params)
    if verify_recaptcha(model: @transfer) && @transfer.save
      return redirect_to admin_transfers_path, notice: 'New transfer added!'
    else 
      return render :new
    end       
  end

  def edit
    @transfer = Transfer.find(params[:id])
  end

  def update
    @transfer = Transfer.find(params[:id])

    if verify_recaptcha(model: @transfer) && @transfer.update_attributes(transfer_params)
      redirect_to admin_transfers_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  def destroy
    @transfer = Transfer.find(params[:id])

    if @transfer.destroy
      redirect_to admin_transfers_path, :notice => "Transfer deleted!"
    else
      redirect_to admin_transfers_path, :flash => {:error => 'Deletion failed!  Please try again'}
    end
  end

  def batch_new
    @transfer = Transfer.new
  end

  def batch_edit
    @transfer = Transfer.new
  end

  def confirm_create
    @transfer = Transfer.new
    uploader = SubjectUploader.new
    uploader.store!(params[:csv_file])
    @csv_file = uploader.current_path
    @errors = []
    uniq_ids = {}

    # validate input file
    headers = CSV.open(@csv_file, 'r') { |csv| csv.first }
    @this_sep = ','
    if headers.size < 2
      @this_sep = "\t"
      headers = CSV.open(@csv_file, 'r', :col_sep => @this_sep) { |csv| csv.first }
    end

    fields = "Sample ID,Transfer From,Transfer To,Transfer Amount,Sample Available Amount,Note".split(',').sort
    if headers.sort != fields
      wrong_f = []
      headers.each do |x|
        unless fields.include?(x)
          wrong_f << "'#{x}'"
        end
      end
      @errors << "Wrong fields: #{wrong_f.join(', ')}. The input file must and can only have the following fields: #{fields.join(', ')}"
    end

    CSV.foreach(@csv_file, headers: true, row_sep: :auto, :col_sep => @this_sep) do |row|
      dat = row.to_hash
      if dat['Sample ID'].blank?
        @errors << "Must provide sample ID"
      elsif !HumanSample.find_by_accession(dat['Sample ID'])
        @errors << "Sample ID #{dat['Sample ID']} not found, please input valid id"
      end
      @errors.uniq!
    end
  end

  def batch_create
    @transfer = Transfer.new
    csv_file = params[:file]
    # check seperator
    headers = CSV.open(csv_file, 'r') { |csv| csv.first }
    this_sep = ','
    if headers.size < 2
      this_sep = "\t"
    end

    begin
      CSV.foreach(csv_file, headers: true, row_sep: :auto, :col_sep => this_sep) do |row|
        dat = row.to_hash
        this_sample = HumanSample.find_by_accession(dat['Sample ID'])
        unless dat['Sample Available Amount'].blank?
          this_sample.avail_amount = dat['Sample Available Amount']
          this_sample.save
        end

        this_transfer = Transfer.new(human_sample_id: this_sample.id, trans_from: dat['Transfer From'], trans_to: dat['Transfer To'], amount: dat['Transfer Amount'], note: dat['Note'])
        this_transfer.save
      end
      return redirect_to admin_transfers_path

    rescue 
      return redirect_to '/admin/transfers/batch_new', :flash => {:error => "Adding new transfers FAILED! try again"}
    end
  end

  def send_template
    dat = "Sample ID,Transfer From,Transfer To,Transfer Amount,Sample Available Amount,Note"
    send_data dat, :filename => 'transfer_upload_template.csv', :type => "text/csv", :disposition => 'attachment'
  end

  private

  def transfer_params
    params.require(:transfer).permit!
  end   

end
