class Visit < ApplicationRecord
  belongs_to :human
  belongs_to :visit_type

  has_many :human_samples

  validates_uniqueness_of :human_id, scope: :visit_type_id
  validates_presence_of :human
  validates_presence_of :visit_type_id

  # settings for filterrific
  filterrific :available_filters => %w[
      search_query
      with_type
      above_age
  ]

  # default for will_paginate
  self.per_page = 20

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    joins(:human).where("humen.accession LIKE ? OR visits.diagnosis LIKE ? OR visits.note LIKE ?", "%%#{query}%%", "%%#{query}%%", "%%#{query}%%")
  }

  scope :with_type, lambda { |type_ids|
    where(:visit_type_id => [*type_ids])
  }

  scope :above_age, lambda { |val|
    where("age > ?", val)
  }
  
  def to_s
    "#{human.accession}-#{visit_type.value}"
  end
end
