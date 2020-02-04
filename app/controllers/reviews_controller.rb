class ReviewsController < ApplicationController

  def new
    @shelter_id = params[:shelter_id]
  end

  def create
    review = Review.new(review_params)
    review.save!
    redirect_to "/shelters/#{params[:shelter_id]}"
  end

  def edit
    @review = Review.find(params[:review_id])
  end

  def update
    review = Review.find(params[:review_id])
    if review.update(review_params) == false
      flash[:notice] = "A required field is missing; please fill out all fields!"
      redirect_to "/shelters/#{review.id}/reviews/edit"
    elsif review.update(review_params) == true
      redirect_to "/shelters/#{review.shelter_id}"
    end
  end

  private

  def review_params
    params.permit(:title, :rating, :content, :picture, :shelter_id)
  end

end
