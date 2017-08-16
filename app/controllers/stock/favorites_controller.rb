class Stock::FavoritesController < ApplicationController
  authorize_resource :class => :stock

  layout 'stock'

  def index
    @fav_samples = current_user.fav_samples
    @fav_subjects = current_user.fav_subjects

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=my_favorites.csv"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def create
    if params[:type] == 'subject'
      @favorite = FavSubject.new(:user_id => params[:user_id], :human_id => params[:subject_id])
    else
      @favorite = FavSample.new(:user_id => params[:user_id], :human_sample_id => params[:sample_id])
    end
    @favorite.save
    redirect_to :back
  end

  def destroy
    if params[:type] == 'subject'
      @favorite = FavSubject.find(params[:id])
    else
      @favorite = FavSample.find(params[:id])
    end

    @favorite.destroy
    redirect_to stock_favorites_path
  end

  private

  def favorite_params
    params.permit(:user_id, :sample_id, :subject_id, :type)
  end   

end
