class VisitType < ApplicationRecord
  has_many :visits

  validates :value, uniqueness: { case_sensitive: false }, presence: true
  
  def to_s
    value
  end
  
  def self.options_for_select
    order('value').map { |e| [e.value, e.id] }
  end

end
