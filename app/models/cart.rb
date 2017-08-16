class Cart < ApplicationRecord
  belongs_to :user
  belongs_to :human_sample
end
