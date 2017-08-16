class Admin::HumenController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  require 'csv'

  def index
    @ops = ['Status', 'ID', 'Cohort', 'Gender', 'Race', 'Population', 'Note']
    @subjects = Human.paginate(:page => params[:page], :per_page => 10).order('updated_at DESC')
  end

  def search_results
    @ops = ['Status', 'ID', 'Cohort', 'Gender', 'Race', 'Population', 'Note']

    if params['key'] == 'Status'
      @subjects = Human.joins(:status).where("statuses.name LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'ID'
      @subjects = Human.where("accession LIKE ? OR other_ids LIKE ?", "%%#{params['value']}%%", "%%#{params['value']}%%")
    elsif params['key'] == 'Cohort'
      @subjects = Human.joins(:cohorts).where("cohorts.name LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Gender'
      @subjects = Human.joins(:gender).where("genders.name LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Race'
      @subjects = Human.joins(:race).where("races.name LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Population'
      @subjects = Human.joins(:population).where("populations.name LIKE ?", "%%#{params['value']}%%")
    else
      @subjects = Human.where("note LIKE ?", "%%#{params['value']}%%")
    end

  end

  def new
    @human = Human.new
  end

  def create
    human_params[:other_ids] = human_params[:other_ids].split("\r\n").join('; ')
    @human = Human.new(human_params)
    if verify_recaptcha(model: @human) && @human.save
      return redirect_to admin_humen_path, notice: 'New human added!'
    else 
      return render :new
    end       
  end

  def edit
    @human = Human.find(params[:id])
    @other_ids = ''
    unless @human.other_ids.blank?
      @other_ids = @human.other_ids.split('; ').join("\n")
    end
  end

  def update
    human_params[:other_ids] = human_params[:other_ids].split("\r\n").join('; ')
    @human = Human.find(params[:id])

    if verify_recaptcha(model: @human) && @human.update_attributes(human_params)
      redirect_to admin_humen_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  def destroy
    @human = Human.find(params[:id])

    if @human.destroy
      redirect_to admin_humen_path, :notice => "Subject deleted!"
    else
      redirect_to admin_humen_path, :flash => {:error => 'Deletion failed!  Please try again'}
    end
  end

  def batch_new
    @human = Human.new
  end

  def batch_edit
    @human = Human.new
  end

  def confirm_create
    @human = Human.new
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

    fields = "Status,ID,Other IDs,Cohort,Gender,Race,Population,Note".split(',').sort
    if headers.sort != fields
      wrong_f = []
      headers.each do |x|
        unless fields.include?(x)
          wrong_f << "'#{x}'"
        end
      end
      @errors << "Wrong fields: #{wrong_f.join(', ')}. The input file must and can only have the following fields: Status,ID,Other IDs,Cohort,Gender,Race,Population,Note"
    end

    CSV.foreach(@csv_file, headers: true, row_sep: :auto, :col_sep => @this_sep) do |row|
      dat = row.to_hash
      if dat['ID'].blank?
        @errors << "Must provide subject ID"
      elsif Human.find_by_accession(dat['ID'])
        @errors << "ID #{dat['ID']} already used. Assign another ID for the subject"
      elsif Human.where("other_ids LIKE ?", "%%#{dat['ID']}%%").count != 0
        @errors << "ID #{dat['ID']} already used. Assign another ID for the subject"
      elsif uniq_ids.has_key?(dat['ID'])
        @errors << "Duplicated ID found in the input file: #{dat['ID']}"
      end
      uniq_ids[dat['ID']] = 0

      unless dat['Other IDs'].blank?
        dat['Other IDs'].split(';').each do |i|
          i.strip!
          if Human.find_by_accession(i) or Human.where("other_ids LIKE ?", "%%#{i}%%").count != 0
            @errors << "Other IDs #{i} already used. Check if this subject is already in the system"
          end
        end
      end

      unless dat['Race'].blank?
        dat['Race'].split('/').each do |r|
          r.strip!
          unless Race.find_by_name(r)
            @errors << "invalid race: #{r}. To add new race, use administration panel"
          end
        end
      end

      unless dat['Status'].blank?
        unless Status.find_by_name(dat['Status']) 
          @errors << "invalid status: #{dat['Status']}. To add new status, use administration panel"
        end
      end

      if dat['Cohort'].blank?
        @errors << "Must provide cohort info"
      else
        dat['Cohort'].split(';').each do |ch|
          ch.strip!
          unless Cohort.find_by_name(ch) 
            @errors << "invalid cohort: #{ch}. To add new cohort, use administration panel"
          end
        end
      end

      unless dat['Gender'].blank?
        unless Gender.find_by_name(dat['Gender']) 
          @errors << "invalid gender: #{dat['Gender']}. To add new gender, use administration panel"
        end
      end

      unless dat['Population'].blank?
        unless Population.find_by_name(dat['Population']) 
          @errors << "invalid population: #{dat['Population']}. To add new population, use administration panel"
        end
      end

      @errors.uniq!
    end
  end

  def confirm_update
    @human = Human.new
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

    fields = "Status,ID,Other IDs,Cohort,Gender,Race,Population,Note".split(',')
    headers.each do |h|
      unless fields.include?(h)
        @errors << "Wrong fields: #{h}. The input file can only have the following fields: Status,ID,Other IDs,Cohort,Gender,Race,Population,Note"
      end
    end

    CSV.foreach(@csv_file, headers: true, row_sep: :auto, :col_sep => @this_sep) do |row|
      dat = row.to_hash
      if dat['ID'].blank?
        @errors << "Must provide subject ID"
      elsif !(Human.find_by_accession(dat['ID']))
        @errors << "ID #{dat['ID']} not found"
      end

      unless dat['Race'].blank?
        dat['Race'].split('/').each do |r|
          r.strip!
          unless Race.find_by_name(r)
            @errors << "invalid race: #{r}. To add new race, use administration panel"
          end
        end
      end

      unless dat['Status'].blank?
        unless Status.find_by_name(dat['Status']) 
          @errors << "invalid status: #{dat['Status']}. To add new status, use administration panel"
        end
      end

      unless dat['Cohort'].blank?
        dat['Cohort'].split(';').each do |ch|
          ch.strip!
          unless Cohort.find_by_name(ch) 
            @errors << "invalid cohort: #{ch}. To add new cohort, use administration panel"
          end
        end
      end

      unless dat['Gender'].blank?
        unless Gender.find_by_name(dat['Gender']) 
          @errors << "invalid gender: #{dat['Gender']}. To add new gender, use administration panel"
        end
      end

      unless dat['Population'].blank?
        unless Population.find_by_name(dat['Population']) 
          @errors << "invalid population: #{dat['Population']}. To add new population, use administration panel"
        end
      end

      @errors.uniq!
    end
  end

  def batch_create
    @human = Human.new
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
        this_human = Human.new({accession: dat['ID'], note: dat['Note']})
        if dat['Status'].blank?
          this_human.status = Status.find_by_name('Valid')
        else
          this_human.status = Status.find_by_name(dat['Status'])
        end
        this_human.other_ids = dat['Other IDs'].split(';').map {|x| x.strip}.join('; ') unless dat['Other IDs'].blank?
        this_human.gender = Gender.find_by_name(dat['Gender']) unless dat['Gender'].blank?
        this_human.population = Population.find_by_name(dat['Population']) unless dat['Population'].blank?

        unless dat['Race'].blank?
          dat['Race'].split('/').each do |r|
            r.strip!
            this_human.races << Race.find_by_name(r)
          end
        end

        unless dat['Cohort'].blank?
          dat['Cohort'].split(';').each do |ch|
            ch.strip!
            this_human.cohorts << Cohort.find_by_name(ch)
          end
        end

        this_human.save
      end
      return redirect_to admin_humen_path, :flash => {:notice => "Human subjects added!"}

    rescue 
      return redirect_to '/admin/humen/batch_new', :flash => {:error => "Adding new human subjects FAILED! try again"}
    end

  end

  def batch_update
    @human = Human.new
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
        this_human = Human.find_by_accession(dat['ID'])
        this_human.status = Status.find_by_name(dat['Status']) unless dat['Status'].blank?
        this_human.other_ids = dat['Other IDs'].split(';').map {|x| x.strip}.join('; ') unless dat['Other IDs'].blank?
        this_human.gender = Gender.find_by_name(dat['Gender']) unless dat['Gender'].blank?
        this_human.note = dat['Note'] unless dat['Note'].blank?
        this_human.population = Population.find_by_name(dat['Population']) unless dat['Population'].blank?

        unless dat['Race'].blank?
          dat['Race'].split('/').each do |r|
            r.strip!
            this_race = Race.find_by_name(r)
            this_human.races << this_race unless this_human.races.include?(this_race)
          end
        end

        unless dat['Cohort'].blank?
          dat['Cohort'].split(';').each do |ch|
            ch.strip!
            this_cohort = Cohort.find_by_name(ch)
            this_human.cohorts << this_cohort unless this_human.cohorts.include?(this_cohort)
          end
        end

        this_human.save
      end
      return redirect_to admin_humen_path, :flash => {:notice => "Human subjects updated!"}

    rescue 
      return redirect_to '/admin/humen/batch_edit', :flash => {:error => "Updating human subjects FAILED! try again"}
    end

  end

  def send_template
    dat = "Status,ID,Other IDs,Cohort,Gender,Race,Population,Note"
    send_data dat, :filename => 'human_subject_upload_template.csv', :type => "text/csv", :disposition => 'attachment'
  end

  private

  def human_params
    params.require(:human).permit!
  end   

end
