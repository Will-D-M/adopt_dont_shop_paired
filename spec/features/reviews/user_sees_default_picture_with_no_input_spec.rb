require 'rails_helper'

RSpec.describe 'default pet picture' do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: "80202")

    title = "Good"
    rating = 5
    content = "I found my new best friend"
    @review1 = Review.create(title: title, rating: rating, content: content, picture: "", shelter_id: "#{@shelter_1.id}")
    @review2 = Review.create(title: "ok", rating: 3, content: "yea, yea", picture: nil, shelter_id: "#{@shelter_1.id}")
    @review3 = Review.create(title: "maybe", rating: 2, content: "so so", picture: "", shelter_id: "#{@shelter_1.id}")
    @review4 = Review.create(title: "exceptional", rating: 8, content: "amazing", picture: nil, shelter_id: "#{@shelter_1.id}")
    @review5 = Review.create(title: "bad", rating: 1, content: "hate it", picture: "https://images.unsplash.com/photo-1548199973-03cce0bbc87b?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80", shelter_id: "#{@shelter_1.id}")

  end

  scenario "enter nothing for picture and have default image inserted" do
    visit "/shelters/#{@shelter_1.id}"
    picture = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"

    expect(page).to have_css("img[src*='#{picture}']")
  end
end
