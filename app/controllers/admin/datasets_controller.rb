class Admin::DatasetsController < ApplicationController
  authorize_resource :class => :admin
  layout 'admin'

  def index
    @datasets = Dataset.all.paginate(:page => params[:page], :per_page => 10).order('updated_at DESC')
    @ops = ['Subject ID', 'Title', 'Availability', 'Contributor', 'PI', 'Note']
  end

  def search_results
    @ops = ['Subject ID', 'Title', 'Availability', 'Contributor', 'PI', 'Note']
    if params['key'] == 'Subject ID'
      @datasets = Dataset.joins(:human).where("humen.accession LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Title'
      @datasets = Dataset.where("title LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Availability'
      @datasets = Dataset.where("availability LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Contributor'
      @datasets = Dataset.where("contributors LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'PI'
      @datasets = Dataset.where("pi LIKE ?", "%%#{params['value']}%%")
    else
      @datasets = Dataset.where("note LIKE ?", "%%#{params['value']}%%")
    end
  end

  def new
    @dataset = Dataset.new
  end

  def create
    @dataset = Dataset.new(dataset_params)
    if verify_recaptcha(model: @dataset) && @dataset.save
      return redirect_to admin_datasets_path, notice: 'New dataset added!'
    else 
      return render :new
    end       
  end

  def edit
    @dataset = Dataset.find(params[:id])
  end

  def update
    @dataset = Dataset.find(params[:id])

    if verify_recaptcha(model: @dataset) && @dataset.update_attributes(dataset_params)
      redirect_to admin_datasets_path, :notice => "Information updated."
    else
      render :edit
    end

  end

  def destroy
    @dataset = Dataset.find(params[:id])
    @dataset.remove_file!

    if @dataset.destroy
      redirect_to admin_datasets_path, :notice => "Dataset deleted!"
    else
      redirect_to admin_datasets_path, :flash => {:error => 'Deletion failed!  Please try again'}
    end
  end

  private

  def dataset_params
    params.require(:dataset).permit!
  end   

end
