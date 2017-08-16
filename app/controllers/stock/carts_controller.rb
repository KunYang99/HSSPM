class Stock::CartsController < ApplicationController
  authorize_resource :class => :stock

  layout 'stock'

  def index
    @carts = current_user.carts

    respond_to do |format|
      format.html
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=submit_form_#{current_user.name}.csv"
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  def create
    @cart = Cart.new(:user_id => params[:user_id], :human_sample_id => params[:sample_id])
    @cart.save
    redirect_to :back
  end

  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy
    redirect_to stock_carts_path
  end

  private

  def cart_params
    params.permit(:user_id, :sample_id)
  end   

end
