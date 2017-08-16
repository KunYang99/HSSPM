class Admin::HumanSamplesController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  require 'csv'

  def index
    @ops = ['Sample ID', 'Type', 'Subject ID', 'Visit', 'Main Location', 'Note']
    @samples = HumanSample.paginate(:page => params[:page], :per_page => 10).order('updated_at DESC')
  end

  def search_results
    @ops = ['Sample ID', 'Type', 'Subject ID', 'Visit', 'Main Location', 'Note']

    if params['key'] == 'Type'
      @samples = HumanSample.joins(:sample_type).where("sample_types.name LIKE ? OR sample_types.note LIKE ?", "%%#{params['value']}%%", "%%#{params['value']}%%")
    elsif params['key'] == 'Sample ID'
      @samples = HumanSample.where("accession LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Subject ID'
      @samples = HumanSample.joins(:visit => :human).where("humen.accession LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Visit'
      @samples = HumanSample.joins(:visit => :visit_type).where("visit_types.value LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Main Location'
      @samples = HumanSample.joins(:main_location).where("main_locations.name LIKe ?", "%%#{params['value']}%%")
    else
      @samples = HumanSample.where("note LIKE ?", "%%#{params['value']}%%")
    end

  end

  def new
    @human_sample = HumanSample.new
  end

  def create
    @human_sample = HumanSample.new(human_sample_params)
    if verify_recaptcha(model: @human_sample) && @human_sample.save
      return redirect_to admin_human_samples_path, notice: 'New human_sample added!'
    else 
      return render :new
    end       
  end

  def edit
    @human_sample = HumanSample.find(params[:id])
  end

  def update
    @human_sample = HumanSample.find(params[:id])

    if verify_recaptcha(model: @human_sample) && @human_sample.update_attributes(human_sample_params)
      redirect_to admin_human_samples_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  def destroy
    @human_sample = HumanSample.find(params[:id])

    if @human_sample.destroy
      redirect_to admin_human_samples_path, :notice => "Sample deleted!"
    else
      redirect_to admin_human_samples_path, :flash => {:error => 'Deletion failed!  Please try again'}
    end
  end

  def batch_new
    @human_sample = HumanSample.new
  end

  def batch_edit
    @human_sample = HumanSample.new
  end

  def confirm_create
    @human_sample = HumanSample.new
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

    fields = "Sample ID,Type,Subject ID,Visit Type,Original Amount,Available Amount,Concentration,Main Location,Sub Location,Source,Prepared_by,Created_on,Note".split(',').sort
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
      elsif HumanSample.find_by_accession(dat['Sample ID'])
        @errors << "Sample ID #{dat['Sample ID']} already used. Assign another ID for the sample"
      elsif uniq_ids.has_key?(dat['Sample ID'])
        @errors << "Duplicated ID found in the input file: #{dat['Sample ID']}"
      end
      uniq_ids[dat['Sample ID']] = 0

      if dat['Type'].blank?
        @errors << "Must provide sample type"
      else
        unless SampleType.find_by_name(dat['Type']) 
          @errors << "invalid sample type: #{dat['Type']}. To add a new type, use administration panel"
        end
      end

      if dat['Subject ID'].blank? or dat['Visit Type'].blank?
        @errors << "Must provide Subject ID and Visit Type"
      elsif Visit.joins(:human, :visit_type).where("humen.accession = ? AND visit_types.value = ?", dat['Subject ID'], dat['Visit Type']).count == 0
        @errors << "#{dat['Subject ID']}-#{dat['Visit Type']} not found in visit log. To add a new visit, use administration panel"
      end

      unless dat['Main Location'].blank?
        unless MainLocation.find_by_name(dat['Main Location'])
          @errors << "Main Location #{dat['Main Location']} not found.  To add a main location, use administration panel"
        end
      end

      unless dat['Created_on'].blank?
        unless dat['Created_on'].match(/\d\d\d\d-\d\d-\d\d/)
          @errors << "Wrong format: #{dat['Created_on']}, Created_on must in format xxxx-xx-xx"
        end
      end

      @errors.uniq!
    end
  end

  def confirm_update
    @human_sample = HumanSample.new
    uploader = SubjectUploader.new
    uploader.store!(params[:csv_file])
    @csv_file = uploader.current_path
    @errors = []

    # validate input file
    headers = CSV.open(@csv_file, 'r') { |csv| csv.first }
    @this_sep = ','
    if headers.size < 2
      @this_sep = "\t"
      headers = CSV.open(@csv_file, 'r', :col_sep => @this_sep) { |csv| csv.first }
    end

    fields = "Sample ID,Type,Subject ID,Visit Type,Original Amount,Available Amount,Concentration,Main Location,Sub Location,Source,Prepared_by,Created_on,Note".split(',').sort
    headers.each do |h|
      unless fields.include?(h)
        @errors << "Wrong fields: #{h}. The input file can only have the following fields: #{fields}"
      end
    end

    CSV.foreach(@csv_file, headers: true, row_sep: :auto, :col_sep => @this_sep) do |row|
      dat = row.to_hash
      if dat['Sample ID'].blank?
        @errors << "Must provide sample ID"
      elsif !(HumanSample.find_by_accession(dat['Sample ID']))
        @errors << "Sample #{dat['Sample ID']} not found."
      end

      unless dat['Type'].blank?
        unless SampleType.find_by_name(dat['Type']) 
          @errors << "invalid sample type: #{dat['Type']}. To add a new type, use administration panel"
        end
      end

      if dat['Subject ID'].blank? and !(dat['Visit Type'].blank?)
        @errors << "Visit Type is not blank but Subject ID is blank. Subject ID and Visit Type is used as a pair, either both have values or both blank."
      elsif !(dat['Subject ID'].blank?) and dat['Visit Type'].blank?
        @errors << "Visit Type is blank but Subject ID is not blank. Subject ID and Visit Type is used as a pair, either both have values or both blank."
      elsif !(dat['Subject ID'].blank?) and !(dat['Visit Type'].blank?) 
        if Visit.joins(:human, :visit_type).where("humen.accession = ? AND visit_types.value = ?", dat['Subject ID'], dat['Visit Type']).count == 0
          @errors << "#{dat['Subject ID']}-#{dat['Visit Type']} not found in visit log. To add a new visit, use administration panel"
        end
      end

      unless dat['Main Location'].blank?
        unless MainLocation.find_by_name(dat['Main Location'])
          @errors << "Main Location #{dat['Main Location']} not found.  To add a main location, use administration panel"
        end
      end

      unless dat['Created_on'].blank?
        unless dat['Created_on'].match(/\d\d\d\d-\d\d-\d\d/)
          @errors << "Wrong format: #{dat['Created_on']}, Created_on must in format xxxx-xx-xx"
        end
      end

      @errors.uniq!
    end
  end

  def batch_create
    @human_sample = HumanSample.new
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
        this_human_sample = HumanSample.new({accession: dat['Sample ID'], note: dat['Note'], amount: dat['Original Amount'], avail_amount: dat['Available Amount'], sub_location: dat['Sub Location'], source: dat['Source'], prepared_by: dat['Prepared_by'], created_on: dat['Created_on'], concentration: dat['Concentration']})
        this_human_sample.visit_id = Visit.joins(:human, :visit_type).where("humen.accession = ? AND visit_types.value = ?", dat['Subject ID'], dat['Visit Type']).first.id
        this_human_sample.sample_type = SampleType.find_by_name(dat['Type'])
        this_human_sample.main_location = MainLocation.find_by_name(dat['Main Location']) unless dat['Main Location'].blank?

        this_human_sample.save
      end
      return redirect_to admin_human_samples_path, :flash => {:notice => "HumanSample samples added!"}

    rescue 
      return redirect_to '/admin/human_samples/batch_new', :flash => {:error => "Adding new human_sample samples FAILED! try again"}
    end

  end

  def batch_update
    @human_sample = HumanSample.new
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
        this_human_sample = HumanSample.find_by_accession(dat['Sample ID'])
        this_human_sample.note = dat['Note'] unless dat['Note'].blank?
        this_human_sample.amount = dat['Original Amount'] unless dat['Original Amount'].blank?
        this_human_sample.avail_amount = dat['Available Amount'] unless dat['Available Amount'].blank?
        this_human_sample.sub_location = dat['Sub Location'] unless dat['Sub Location'].blank?
        this_human_sample.source = dat['Source'] unless dat['Source'].blank?
        this_human_sample.prepared_by = dat['Prepared_by'] unless dat['Prepared_by'].blank?
        this_human_sample.created_on = dat['Created_on'] unless dat['Created_on'].blank?
        if !(dat['Subject ID'].blank?) and !(dat['Visit Type'].blank?)
          this_human_sample.visit_id = Visit.joins(:human, :visit_type).where("humen.accession = ? AND visit_types.value = ?", dat['Subject ID'], dat['Visit Type']).first.id
        end
        this_human_sample.sample_type = SampleType.find_by_name(dat['Type']) unless dat['Type'].blank?
        this_human_sample.main_location = MainLocation.find_by_name(dat['Main Location']) unless dat['Main Location'].blank?
        this_human.concentration = dat['Concentration'] unless dat['Concentration'].blank?

        this_human_sample.save
      end
      return redirect_to admin_human_samples_path, :flash => {:notice => "Human samples updated!"}

    rescue 
      return redirect_to '/admin/human_samples/batch_edit', :flash => {:error => "Updating human samples FAILED! try again"}
    end

  end

  def send_template
    dat = "Sample ID,Type,Subject ID,Visit Type,Original Amount,Available Amount,Concentration,Main Location,Sub Location,Source,Prepared_by,Created_on,Note"
    send_data dat, :filename => 'human_sample_upload_template.csv', :type => "text/csv", :disposition => 'attachment'
  end

  private

  def human_sample_params
    params.require(:human_sample).permit!
  end   

end
