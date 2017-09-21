class SampleType < ApplicationRecord

  has_paper_trail ignore: [:updated_at, :created_at]

  has_many :human_samples

  validates :name, uniqueness: { case_sensitive: false }, presence: true
  
  def to_s
    name
  end

  def to_desc
    if note.blank?
      name
    else
      note
    end
  end

  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end

end
