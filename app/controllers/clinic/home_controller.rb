class Clinic::HomeController < ApplicationController
  authorize_resource :class => :clinic

  layout 'clinic'

  def index
  end
end
