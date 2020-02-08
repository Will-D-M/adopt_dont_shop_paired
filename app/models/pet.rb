class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications
  before_save :default_values

  def self.favpets(favorites)
    favorites.pets_favorite.keys.map do |petid|
      Pet.find(petid)
    end
  end

  def default_values
    self.adoption_status = "adoptable" if self.adoption_status.nil?
    self.description = "Looking for a home" if self.description.nil?
  end

  def applicant
    pet_applications.where(adopted: true).first.application
  end

end
