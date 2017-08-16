class Admin::VisitsController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @ops = ['Subject ID', 'Visit Type', 'Age', 'Diagnosis', 'Note']
    @visits = Visit.paginate(:page => params[:page], :per_page => 10).order('updated_at DESC')
  end

  def new
    @visit = Visit.new
  end

  def create
    @visit = Visit.new(visit_params)
    if verify_recaptcha(model: @visit) && @visit.save
      return redirect_to admin_visits_path, notice: 'New visit added!'
    else 
      return render :new
    end       
  end

  def edit
    @visit = Visit.find(params[:id])
  end

  def update
    @visit = Visit.find(params[:id])

    if verify_recaptcha(model: @visit) && @visit.update_attributes(visit_params)
      redirect_to admin_visits_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  def search_results
    @ops = ['Subject ID', 'Visit Type', 'Age', 'Diagnosis', 'Note']

    if params['key'] == 'Subject ID'
      @visits = Visit.joins(:human).where("humen.accession LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Visit Type'
      @visits = VisitType.find_by_value(params['value']).visits
    elsif params['key'] == 'Age'
      @visits = Visit.where('age = ?', params['value'])
    elsif params['key'] == 'Diagnosis'
      @visits = Visit.where("diagnosis LIKE ?", "%%#{params['value']}%%")
    else
      @visits = Visit.where("note LIKE ?", "%%#{params['value']}%%")
    end

  end

  def batch_new
    @visit = Visit.new
  end

  def batch_edit
    @visit = Visit.new
  end

  def confirm_create
    @visit = Visit.new
    uploader = SubjectUploader.new
    uploader.store!(params[:csv_file])
    @csv_file = uploader.current_path
    @errors = []
    uniq_visit = {}

    # validate input file
    headers = CSV.open(@csv_file, 'r') { |csv| csv.first }
    @this_sep = ','
    if headers.size < 2
      @this_sep = "\t"
      headers = CSV.open(@csv_file, 'r', :col_sep => @this_sep) { |csv| csv.first }
    end

    fields = "Subject ID,Visit Type,Age,Diagnosis,Note".split(',').sort
    if headers.sort != fields
      wrong_f = []
      headers.each do |x|
        unless fields.include?(x)
          wrong_f << "'#{x}'"
        end
      end
      @errors << "Wrong fields: #{wrong_f.join(', ')}, The input file must and can only have the following fields: #{fields.join(', ')}"
    end

    CSV.foreach(@csv_file, headers: true, row_sep: :auto, :col_sep => @this_sep) do |row|
      dat = row.to_hash
      if dat['Subject ID'].blank?
        @errors << "Must provide subject id"
      elsif !(Human.find_by_accession(dat['Subject ID']))
        @errors << "Subject #{dat['Subject ID']} not found"
      end

      if dat['Visit Type'].blank?
        @errors << "Visit type cannot be blank"
      elsif !(VisitType.find_by_value(dat['Visit Type']))
        @errors << "Visit type #{dat['Visit Type']} not found. To add new visit type, use administration panel"
      else
        if Visit.joins(:human, :visit_type).where("humen.accession = ? AND visit_types.value = ?", dat['Subject ID'], dat['Visit Type']).count > 0
          @errors << "Visit #{dat['Subject ID']}--#{dat['Visit Type']} is already in database"
        end
      end

      if uniq_visit.has_key?("#{dat['Subject ID']}-#{dat['Visit Type']}")
        @errors << "Duplicated visits found in the input file: #{dat['Subject ID']}-#{dat['Visit Type']}"
      end
      uniq_visit["#{dat['Subject ID']}-#{dat['Visit Type']}"] = 0

      @errors.uniq!
    end
  end

  def confirm_update
    @Visit = Visit.new
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

    fields = "Subject ID,Visit Type,Age,Diagnosis,Note".split(',')

    headers.each do |h|
      unless fields.include?(h)
        @errors << "Wrong fields: #{h}. The input file can only have the following fields: #{fields.join(', ')}"
      end
    end

    CSV.foreach(@csv_file, headers: true, row_sep: :auto, :col_sep => @this_sep) do |row|
      dat = row.to_hash
      if dat['Subject ID'].blank?
        @errors << "Must provide subject id"
      elsif !(Human.find_by_accession(dat['Subject ID']))
        @errors << "Subject #{dat['Subject ID']} not found"
      end

      if dat['Visit Type'].blank?
        @errors << "Visit type cannot be blank"
      else
        if Visit.joins(:human, :visit_type).where("humen.accession = ? AND visit_types.value = ?", dat['Subject ID'], dat['Visit Type']).count == 0
          @errors << "Visit #{dat['Subject ID']}--#{dat['Visit Type']} not found"
        end
      end

      @errors.uniq!
    end
  end

  def batch_create
    @visit = Visit.new
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
        this_visit = Visit.new({human: Human.find_by_accession(dat['Subject ID']), visit_type: VisitType.find_by_value(dat['Visit Type']), note: dat['Note'], diagnosis: dat['Diagnosis'], age: dat['Age']})

        this_visit.save
      end
      return redirect_to admin_visits_path, :flash => {:notice => "Visits added!"}

    rescue 
      return redirect_to '/admin/visits/batch_new', :flash => {:error => "Adding new visits FAILED! try again"}
    end

  end

  def batch_update
    @visit = Visit.new
    csv_file = params[:file]
    # check seperator
    headers = CSV.open(csv_file, 'r') { |csv| csv.first }
    this_sep = ','
    if headers.size < 2
      this_sep = "\t"
    end

    # begin
      CSV.foreach(csv_file, headers: true, row_sep: :auto, :col_sep => this_sep) do |row|
        dat = row.to_hash
        this_visit = Visit.joins(:human, :visit_type).where("humen.accession = ? AND visit_types.value = ?", dat['Subject ID'], dat['Visit Type']).first

        unless dat['Diagnosis'].blank?
          this_visit.diagnosis = dat['Diagnosis']
        end

        unless dat['Note'].blank?
          this_visit.note = dat['Note']
        end

        unless dat['Age'].blank?
          this_visit.age = dat['Age']
        end

        this_visit.save
      end
      return redirect_to admin_visits_path, :flash => {:notice => "Visits updated!"}

    # rescue 
      # return redirect_to '/admin/visits/batch_edit', :flash => {:error => "Updating  visits FAILED! try again"}
    # end

  end

  def send_template
    dat = "Subject ID,Visit Type,Age,Diagnosis,Note"
    send_data dat, :filename => 'visit_upload_template.csv', :type => "text/csv", :disposition => 'attachment'
  end

  def destroy
    @visit = Visit.find(params[:id])

    if @visit.destroy
      redirect_to admin_visits_path, :notice => "Visit deleted!"
    else
      redirect_to admin_visits_path, :flash => {:error => 'Deletion failed!  Please try again'}
    end
  end

  private

  def visit_params
    params.require(:visit).permit!
  end   

end
