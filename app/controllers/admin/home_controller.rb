class Admin::HomeController < ApplicationController
  authorize_resource :class => :admin

  layout 'admin'

  def index
    @user_cnt = User.count
    @groups = Group.all
    @subject_cnt = Human.count
    @cohorts = Cohort.all
    @sample_cnt = HumanSample.count
    @project_cnt =Project.count
    @types = SampleType.all
  end
end
