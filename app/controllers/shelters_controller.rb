class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def new
  end

  def create
    shelter = Shelter.create(name: params[:shelter_name],
              address: params[:shelter_address],
              city: params[:shelter_city],
              state: params[:shelter_state],
              zip: params[:shelter_zip])
    redirect_to '/shelters'
  end

  def edit
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({name: params[:shelter_name],
      address: params[:shelter_address], city: params[:shelter_city],
      state: params[:shelter_state], zip: params[:shelter_zip]})
    redirect_to "/shelters/#{shelter.id}"
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end

  def display
    @shelter = Shelter.find(params[:id])
  end
end
