class Stock::MaterialsController < ApplicationController
  authorize_resource :class => :stock

  layout 'stock'

  def index
    @materials = Material.all
  end

end
