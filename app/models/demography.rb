class Demography < ApplicationRecord
  
  has_paper_trail ignore: [:updated_at, :created_at]
  
  belongs_to :human

  def to_s
    data
  end
end
