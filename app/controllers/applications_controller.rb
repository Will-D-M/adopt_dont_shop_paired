class ApplicationsController < ApplicationController
  def new
    @pets = Pet.find(favorites.pets_favorite.keys)
  end

  def create
    application = Application.new(application_params)
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :phone_number, :description)
  end
end
