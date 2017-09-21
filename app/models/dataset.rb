class Dataset < ApplicationRecord

  has_paper_trail ignore: [:updated_at, :created_at]

  mount_uploader :file, DatasetUploader

  belongs_to :human
  has_and_belongs_to_many :projects

  validates_presence_of :title

  # settings for filterrific
  filterrific :available_filters => %w[
      search_query
      with_project
  ]

  # default for will_paginate
  self.per_page = 20

  scope :search_query, lambda { |query|
    return nil  if query.blank?
    joins(:human).where("humen.accession LIKE ? OR datasets.title LIKE ? OR datasets.pi LIKE ? OR datasets.contributors LIKE ? OR datasets.availability LIKE ?", "%%#{query}%%", "%%#{query}%%", "%%#{query}%%", "%%#{query}%%", "%%#{query}%%")
  }

  scope :with_project, lambda { |project_ids|
    joins(:projects).where(:projects => {:id => [*project_ids]})
  }

  def to_s
    title
  end

  def to_projects
    dat = []
    projects.each do |p|
      dat << p.name
    end
    return dat.join(', ')
  end
end
