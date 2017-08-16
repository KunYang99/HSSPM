class FavSubject < ApplicationRecord
  belongs_to :user
  belongs_to :human
end
