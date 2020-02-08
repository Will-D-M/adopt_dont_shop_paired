class Application < ApplicationRecord

  validates_presence_of :name, :address, :city, :state, :zip, :phone_number, :description
  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def get_pet_name
    #return pet name(s) for a given application
    #match application id to pet_application's application id
    #from that pet_application id, match pet_app's pet_id to pet table's id
    # from that pet row, grab pet name
    petids = PetApplication.where(application_id: self.id).pluck(:pet_id)
    Pet.find(petids).pluck(:name)
    # We start with the application id

    #return pet(s) name for pets submitted applications for
  end
end
