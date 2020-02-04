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

  private

  def review_params
    params.permit(:title, :rating, :content, :picture, :shelter_id)
  end

end
