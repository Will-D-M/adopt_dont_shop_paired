class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:id])
  end

  def create
    pet = Pet.create(name: params[:pet_name],
      description: params[:pet_description],
      approximate_age: params[:pet_approximate_age],
      sex: params[:pet_sex], adoption_status: "adoptable",
      shelter_id: params[:id], shelter_name: Shelter.find(params[:id]).name)
    redirect_to "/shelters/#{params[:id].to_i}/pets"
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    pet = Pet.find(params[:id])
    pet.update(image: params[:pet_image], name: params[:pet_name],
      description: params[:pet_description],
      approximate_age: params[:pet_approximate_age],
      sex: params[:pet_sex])
    redirect_to "/pets/#{params[:id]}"
  end

  def destroy
    favorites.remove_pet(params[:id])
    session[:favorites] = favorites.pets_favorite

    Pet.destroy(params[:id])
    redirect_to '/pets'
  end


  def change_adoption
    pet = Pet.find(params[:petid])
    if pet.adoption_status == "adoptable"
      pet.update(adoption_status: "pending")
      pet_app = PetApplication.where(pet_id: params[:petid], application_id: params[:appid])[0]
      pet_app.update(adopted: true)
      pet.update(approved: true)
      redirect_to "/pets/#{pet.id}"
    elsif pet.adoption_status == "pending"
      pet.update(adoption_status: "adoptable")
      pet_app = PetApplication.where(pet_id: params[:petid], application_id: params[:appid])[0]
      pet_app[:adopted] = false
      pet.update(approved: false)
      redirect_to "/applications/#{params[:appid]}"
    end
  end
end
