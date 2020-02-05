class FavoritesController < ApplicationController
  include ActionView::Helpers::TextHelper

  def index
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

  def destroy
    if params[:pet_id] == nil
      favorites.pets_favorite.clear
    else
      pet = Pet.find(params[:pet_id])
      favorites.pets_favorite.delete(params[:pet_id])
      flash[:notice] = "The pet has been removed from your Favorite Pets."
    end
    redirect_back(fallback_location: '/favorites')
  end

end
