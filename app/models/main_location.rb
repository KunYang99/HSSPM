class MainLocation < ApplicationRecord
  has_many :huamn_samples

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  
  def to_s
    name
  end

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

end
