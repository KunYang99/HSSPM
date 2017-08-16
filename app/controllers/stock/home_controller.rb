class Stock::HomeController < ApplicationController
  authorize_resource :class => :stock

  layout 'stock'

  def index
    @user_cnt = User.count
    @valid = Human.joins(:status).where(:statuses => {:name => 'valid'})
    @ops_subject = ['Status', 'ID', 'Cohort', 'Gender', 'Race', 'Population', 'Note']
    @ops_sample = ['Sample ID', 'Type', 'Subject ID', 'Visit', 'Main Location', 'Note']
  end
end
