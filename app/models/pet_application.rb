class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def self.get_pets
    self.all.map {|app| Pet.find(app.pet_id)}
  end

  def get_pets
    petids = PetApplication.where(application_id: self.application_id).pluck(:pet_id)
    Pet.find(petids)
  end
end
