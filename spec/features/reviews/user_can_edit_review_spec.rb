require 'rails_helper'

RSpec.describe 'edit shelter review' do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: "80202")

    title = "Good"
    rating = 5
    content = "I found my new best friend"
    picture = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"
    visit "/shelters/#{@shelter_1.id}"
    click_link 'Add Review'
    fill_in 'Title', with: title
    select rating, from: :rating
    fill_in 'Content', with: content
    fill_in 'Picture', with: picture
    click_button 'Submit'
  end

  scenario "see link to edit shelter review" do
    visit "/shelters/#{@shelter_1.id}"

    expect(page).to have_link("Edit this review!")
  end

  scenario "see edit shelter review form with pre populated data" do
    visit "/shelters/#{@shelter_1.id}"
    click_link("Edit this review!")
    save_and_open_page

    expect(current_path).to eq("/shelters/#{@shelter_1.id}/reviews/edit")
    expect(page).to have_content("Good")
    expect(page).to have_content(5)
    expect(page).to have_content("I found my new best friend")
    expect(page).to have_css("img[src*='#{picture}']")

  end
end
