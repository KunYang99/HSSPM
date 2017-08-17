class Clinic::HomeController < ApplicationController
  authorize_resource :class => :clinic

  layout 'clinic'

  def index
    @ops = ['Status', 'ID', 'IRB', 'Gender', 'Race', 'Population', 'Note']
    @events = Event.where('start >= ?', Time.zone.now.beginning_of_day).order(:start).first(5)
  end
end
