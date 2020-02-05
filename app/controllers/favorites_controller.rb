class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
    @pets = Pet.all
    @fav_pets = favorites.pets_favorite.keys.map do |petid|
      Pet.find(petid)
    end
  end

  def update
    pet = Pet.find(params[:pet_id])
    favorites.add_pet(pet.id)
    session[:favorites] = favorites.pets_favorite
    quantity = favorites.count_of(pet.id)
    flash[:favorite] = "The pet has been added to your favorites list."
    redirect_to "/pets/#{pet.id}"
  end

end
