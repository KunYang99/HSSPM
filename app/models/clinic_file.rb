class ClinicFile < ApplicationRecord
  
  mount_uploader :file, ClinicFileUploader

  validates_presence_of :title
  validates_presence_of :file

end
