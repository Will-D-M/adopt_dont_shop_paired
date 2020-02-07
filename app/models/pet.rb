class Pet < ApplicationRecord
  belongs_to :shelter
  has_many :pet_applications, dependent: :destroy
  has_many :applications, through: :pet_applications

  def self.favpets(favorites)
    favorites.pets_favorite.keys.map do |petid|
      Pet.find(petid)
    end
  end

end
