require 'rails_helper'

RSpec.describe 'edit shelter review' do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: "80202")

    title = "Good"
    rating = 5
    content = "I found my new best friend"
    picture = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"
    @review1 = Review.create(title: title, rating: rating, content: content, picture: picture, shelter_id: "#{@shelter_1.id}")
  end

  scenario "see link to edit shelter review" do
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link("Edit this review!")
  end

  scenario "see edit shelter review form with pre populated data" do
    visit "/shelters/#{@shelter_1.id}"
    click_link("Edit this review!")

    expect(current_path).to eq("/shelters/#{@review1.id}/reviews/edit")
    expect(page).to have_selector("input[value=#{@review1.title}]")
    expect(page).to have_selector("input[value=#{@review1.rating}]")
    expect(page).to have_xpath("//input[@value='#{@review1.content}']")
    expect(find_field('Picture').value).to eq(@review1.picture)
  end

end
