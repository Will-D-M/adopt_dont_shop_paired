class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.get_pets
    self.all.map {|app| Pet.find(app.pet_id)}
  end
end
