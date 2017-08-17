class Human < ApplicationRecord
  belongs_to :population
  belongs_to :gender
  belongs_to :status

  has_one :demography
  accepts_nested_attributes_for :demography
  has_many :visits, inverse_of: :human
  accepts_nested_attributes_for :visits
  has_many :datasets
  has_many :human_samples, through: :visits
  has_and_belongs_to_many :races
  has_and_belongs_to_many :cohorts
  has_and_belongs_to_many :irbs

  validates :accession, uniqueness: { case_sensitive: false }, presence: true
  validates_presence_of :status_id

  scope :cohort_of, -> (ch) { joins(:cohorts).where("cohorts.name LIKE ?", ch) }
  
  # settings for filterrific
  filterrific :available_filters => %w[
      search_query
      with_status
      with_cohort
      with_irb
      with_gender
      with_race
      with_population
  ]

  # default for will_paginate
  self.per_page = 20

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    where("accession LIKE ? OR other_ids LIKE ? OR note LIKE ?", "%%#{query}%%", "%%#{query}%%", "%%#{query}%%")
  }

  scope :with_status, lambda { |status_ids|
    where(:status_id => [*status_ids])
  }

  scope :with_gender, lambda { |gender_ids|
    where(:gender_id => [*gender_ids])
  }

  scope :with_population, lambda { |pop_ids|
    where(:population_id => [*pop_ids])
  }

  scope :with_race, lambda { |race_ids|
    joins(:races).where(:races => {:id => [*race_ids]})
  }

  scope :with_cohort, lambda { |cohort_ids|
    joins(:cohorts).where(:cohorts => {:id => [*cohort_ids]})
  }

  scope :with_irb, lambda { |irb_ids|
    joins(:irbs).where(:irbs => {:id => [*irb_ids]})
  }

  def to_s
    accession
  end

  def to_races
    r_list = []
    races.each do |r|
      r_list << r.name
    end
    return r_list.join('/')
  end

  def to_cohorts
    c_list = []
    cohorts.each do |ch|
      c_list << ch.name
    end
    return c_list.join('; ')
  end

  def to_irbs
    c_list = []
    irbs.each do |i|
      c_list << i.number
    end
    return c_list.join('; ')
  end

end
