class Group < ApplicationRecord

  has_paper_trail ignore: [:updated_at, :created_at]

  has_and_belongs_to_many :users

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  
  def to_s
    name
  end
end
