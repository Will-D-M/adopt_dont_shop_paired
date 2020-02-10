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
    shelter = Shelter.new(name: params[:shelter_name],
              address: params[:shelter_address],
              city: params[:shelter_city],
              state: params[:shelter_state],
              zip: params[:shelter_zip])
    if shelter.save
      redirect_to '/shelters'
      flash[:success] = "The shelter has been created!"
    else
      flash.now[:notice] = shelter.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    shelter = Shelter.find(params[:id])
    shelter.update({name: params[:shelter_name],
      address: params[:shelter_address], city: params[:shelter_city],
      state: params[:shelter_state], zip: params[:shelter_zip]})

    if shelter.save
      redirect_to "/shelters/#{shelter.id}"
      flash[:success] = "The shelter has been updated!"
    else
      flash.now[:notice] = shelter.errors.full_messages.to_sentence
      render :new
    end
  end

  def destroy
    Shelter.destroy(params[:id])
    redirect_to '/shelters'
  end

  def display
    @shelter = Shelter.find(params[:id])
  end
end
