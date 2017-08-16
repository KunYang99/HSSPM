class Stock::ContactsController < ApplicationController
  authorize_resource :class => :stock

  layout 'stock'

  def index
  end

end
