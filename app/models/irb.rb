class Irb < ApplicationRecord
  
  has_paper_trail ignore: [:updated_at, :created_at]
  
  has_and_belongs_to_many :humen
  validates_presence_of :number

  def to_s
    name
  end
  
  def self.options_for_select
    order('id').map { |e| [e.number, e.id] }
  end

end
