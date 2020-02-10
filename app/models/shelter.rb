class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
  has_many :reviews, dependent: :destroy

  def pets_pending?
    pets.any? do |pet|
      pet.adoption_status == "pending"
    end
  end

end
