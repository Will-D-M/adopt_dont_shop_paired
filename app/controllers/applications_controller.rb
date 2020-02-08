class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find(favorites.pets_favorite.keys)
  end

  def create
    application = Application.new(application_params)

    if application.save == true
      pets = Pet.find(params[:pet_ids])

      pets.each {|pet| PetApplication.create(pet_id: pet.id, application_id: application.id)}
      pets.each {|pet| favorites.remove_pet(pet.id)}

      session[:favorites] = favorites.pets_favorite
      flash[:submitted] = "Your application for the selected pets went through."
      redirect_to '/favorites'

    elsif application.save == false

      flash[:missingfields] = "You must complete all fields in order for your application to be considered."
      redirect_to '/applications/new'
    end
  end

  def show
    @application = Application.find(params[:application_id])
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
