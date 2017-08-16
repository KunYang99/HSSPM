class User < ApplicationRecord

  has_secure_password

  has_and_belongs_to_many :groups
  has_many :carts
  has_many :fav_samples
  has_many :fav_subjects

  validates :name, uniqueness: { case_sensitive: false }
  validates :username, uniqueness: { case_sensitive: false }
  validates_format_of :gmail, :with => /\A[^@\s]+@gmail.com/, :allow_blank => true
  validates_format_of :email, :with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, :allow_blank => true

  scope :admin, -> {joins(:groups).where("groups.name LIKE ?", 'admin')}
  scope :sample_db, -> {joins(:groups).where("groups.name LIKE ?", 'sample')}
  scope :fep, -> {joins(:groups).where("groups.name LIKE ?", 'FEP')}
  scope :clinic, -> {joins(:groups).where("groups.name LIKE ?", 'clinic')}
  scope :disabled, -> {joins(:groups).where("groups.name LIKE ?", 'disabled')}

  def to_s
    name
  end

  def to_groups
    g_name = []
    groups.each {|g| g_name << g.name}
    return g_name.join(', ')
  end

  #membership utility function
  def member?(groupname)
    groups.where(:name => groupname ).size() > 0 
  end

  def has_cart?(sample_id)
    if Cart.where("user_id = ? and human_sample_id = ?", id, sample_id).count == 0
      false
    else
      true
    end
  end

  def has_fav_sample?(sample_id)
    if FavSample.where("user_id = ? and human_sample_id = ?", id, sample_id).count == 0
      false
    else
      true
    end
  end

  def has_fav_subject?(subject_id)
    if FavSubject.where("user_id = ? and human_id = ?", id, subject_id).count == 0
      false
    else
      true
    end
  end

end 
