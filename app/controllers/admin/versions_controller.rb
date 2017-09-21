class Admin::VersionsController < ApplicationController
  authorize_resource :class => :admin

  layout 'admin'

  def index
    @ops = ['Data', 'Type', 'Who', 'After']
    @changes = Version.paginate(:page => params[:page], :per_page => 15).order('created_at DESC')
  end

  def search_results
    @ops = ['Data', 'Type', 'Who', 'After']
    @data = []

    if params['key'] == 'Data'
      if ['Human Subject', 'human subject', 'Subject', 'subject'].include?(params['value'])
        @data = Version.where("item_type LIKE 'Human'")
      elsif ['Human Sample', 'human sample', 'Sample', 'sample'].include?(params['value'])
        @data = Version.where("item_type LIKE 'HumanSample'")
      elsif ['Demographic Data', 'demographic data', 'demographic'].include?(params['value'])
        @data = Version.where("item_type LIKE 'Demography'")
      else
        @data = Version.where("item_type LIKE ?", "%%#{params['value']}%%")
      end
    elsif params['key'] == 'Type'
      @data = Version.where("event LIKE ?", "%%#{params['value']}%%")
    elsif params['key'] == 'Who'
      user = User.where("name LIKE ?", "%%#{params['value']}%%")
      if user.blank?
        @data = []
      else
        @data = Version.where("whodunnit = #{user[0].id}")
      end
    else
      @data = Version.where("created_at > ?", params['value'])
    end
  end
end
