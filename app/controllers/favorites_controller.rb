class FavoritesController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    flash[:favorite] = "The pet has been added to your favorites list."
    redirect_to "/pets/#{pet.id}"
  end

end
