class Transfer < ApplicationRecord
  belongs_to :human_sample
  
  validates_presence_of :human_sample_id
end
