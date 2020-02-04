require 'rails_helper'

RSpec.describe 'delete shelter review' do
  before(:each) do
    @shelter_1 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: "80202")

    title = "Good"
    rating = 5
    content = "I found my new best friend"
    picture = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"
    @review1 = Review.create(title: title, rating: rating, content: content, picture: picture, shelter_id: "#{@shelter_1.id}")

    title2 = "Horrible"
    rating2 = 1
    content2 = "I kicked that dog out."
    picture2 = "https://previews.123rf.com/images/plysuikvv/plysuikvv1606/plysuikvv160600106/60811009-enraged-aggressive-angry-dog-grin-jaws-with-fangs-hungry-drool-.jpg"
    @review2 = Review.create(title: title2, rating: rating2, content: content2, picture: picture2, shelter_id: "#{@shelter_1.id}")
  end

  scenario "see delete review link" do
    visit "/shelters/#{@shelter_1.id}"

    within("#review#{@review1.id}") do
      expect(page).to have_link("Delete this review!")
    end

    within "#review#{@review2.id}" do
      expect(page).to have_link("Delete this review!")
    end
  end

  scenario "click delete and return to shelter show page" do
    visit "/shelters/#{@shelter_1.id}"
    title = "Good"
    title2 = "Horrible"

    within("#review#{@review1.id}") do
      click_link("Delete this review!")
    end

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).to have_content(title2)
    expect(page).not_to have_content(title)

    within("#review#{@review2.id}") do
      click_link("Delete this review!")
    end

    expect(current_path).to eq("/shelters/#{@shelter_1.id}")
    expect(page).not_to have_content(title2)
    expect(page).not_to have_content(title)
  end
end
