class ClinicFile < ApplicationRecord

  has_paper_trail ignore: [:updated_at, :created_at]

  mount_uploader :file, ClinicFileUploader

  validates_presence_of :title
  validates_presence_of :file

end
