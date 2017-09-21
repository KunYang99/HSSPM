class Gender < ApplicationRecord

  has_paper_trail ignore: [:updated_at, :created_at]

  has_many :humen

  validates :name, uniqueness: { case_sensitive: false }, presence: true

  def to_s
    name
  end

  def self.options_for_select
    order('name').map { |e| [e.name, e.id] }
  end

end
