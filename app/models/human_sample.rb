class HumanSample < ApplicationRecord
  belongs_to :sample_type
  belongs_to :main_location
  belongs_to :visit

  has_many :transfers

  delegate :human, :to => :visit
  delegate :visit_type, :to => :visit

  validates :accession, uniqueness: { case_sensitive: false }, presence: true
  validates_presence_of :sample_type_id
  validates_presence_of :visit_id

  # settings for filterrific
  filterrific :available_filters => %w[
      search_query
      with_type
      with_location
  ]

  # default for will_paginate
  self.per_page = 20

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    where("accession LIKE ? ", "%%#{query}%%")
  }

  scope :with_type, lambda { |type_ids|
    where(:sample_type_id => [*type_ids])
  }

  scope :with_location, lambda { |loc_ids|
    where(:main_location_id => [*loc_ids])
  }

  def to_s
    accession
  end
end
