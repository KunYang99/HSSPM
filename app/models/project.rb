class Project < ApplicationRecord
  has_and_belongs_to_many :datasets

  validates_inclusion_of :progress, :in => 0..100, :message => 'must between 0 to 100'

  def to_s
    name
  end
  
  def self.options_for_select
    order('name').map { |e| [e.name, e.id] }
  end

end
