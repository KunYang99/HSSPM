class Admin::VersionsController < ApplicationController
  authorize_resource :class => :admin

  layout 'admin'

  def index
    @changes = Version.paginate(:page => params[:page], :per_page => 15).order('created_at DESC')
  end
end
