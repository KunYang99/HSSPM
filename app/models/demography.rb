class Demography < ApplicationRecord
  belongs_to :human

  def to_s
    data
  end
end
