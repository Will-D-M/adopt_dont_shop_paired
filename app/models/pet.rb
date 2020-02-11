class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications
  before_save :default_values
  validates_presence_of :name
  validates_presence_of :approximate_age
  validates_presence_of :sex
  validates_presence_of :description


  def default_values
    self.adoption_status = "adoptable" if self.adoption_status.nil?
  end

  def applicant
    pet_applications.where(adopted: true).first.application
  end

  def self.pets_with_applications
    select(:name, :id, :approved).joins(:pet_applications)
  end

  def self.fav_pets(favorites)
    find(favorites.pets_favorite.keys)
  end

end
