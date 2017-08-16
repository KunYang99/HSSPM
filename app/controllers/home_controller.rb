class HomeController < ApplicationController
  skip_before_action :is_valid_session?

  def index
    @user_cnt = User.count
    @valid = Human.joins(:status).where(:statuses => {:name => 'valid'})
    @ops_subject = ['Status', 'ID', 'Cohort', 'Gender', 'Race', 'Population', 'Note']
    @ops_sample = ['Sample ID', 'Type', 'Subject ID', 'Visit', 'Main Location', 'Note']
  end
end
