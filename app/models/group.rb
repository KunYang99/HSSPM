class Group < ApplicationRecord
  has_and_belongs_to_many :users

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  
  def to_s
    name
  end
end
