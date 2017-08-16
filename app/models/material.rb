class Material < ApplicationRecord
  
  mount_uploader :file, MaterialUploader

  validates_presence_of :title
  validates_presence_of :file

end
