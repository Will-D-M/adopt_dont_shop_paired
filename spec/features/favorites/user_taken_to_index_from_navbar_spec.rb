require 'rails_helper'

RSpec.describe 'index page from navbar', type: :feature do
  before(:each) do
    @shelter1 = Shelter.create(name: "Bloke",
    address: "123456 E. Koko St.",
    city: "Aville",
    state: "CO",
    zip: "83504")
    @shelter2 = Shelter.create(name: "Stevie",
    address: "12765 E. Seesay St.",
    city: "Aville",
    state: "CO",
    zip: "83571")

    pet1_path = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"
    pet2_path = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"

    @pet1 = Pet.create(image: pet1_path,
    name: "Patra",
    approximate_age: 2,
    sex: "free",
    shelter_id: @shelter1.id,
    shelter_name: @shelter1.name)
    @pet2 = Pet.create(image: pet2_path,
    name: "Shabba",
    approximate_age: 5,
    sex: "indigo",
    shelter_id: @shelter2.id,
    shelter_name: @shelter2.name)

    title = "Good"
    rating = 5
    content = "I found my new best friend"
    picture = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"
    @review1 = Review.create(title: title, rating: rating, content: content, picture: picture, shelter_id: "#{@shelter1.id}")

    title2 = "Horrible"
    rating2 = 1
    content2 = "I kicked that dog out."
    picture2 = "https://previews.123rf.com/images/plysuikvv/plysuikvv1606/plysuikvv160600106/60811009-enraged-aggressive-angry-dog-grin-jaws-with-fangs-hungry-drool-.jpg"
    @review2 = Review.create(title: title2, rating: rating2, content: content2, picture: picture2, shelter_id: "#{@shelter2.id}")
    visit "/pets/#{@pet1.id}"
    click_button("Favorite this pet.")
    visit "/pets/#{@pet2.id}"
    click_button("Favorite this pet.")
  end

  scenario "see favorites link in navigation bar" do
    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_link("Favorites: 2 pets")

    visit "/pets/#{@pet2.id}"

    expect(page).to have_link("Favorites: 2 pets")
  end

  scenario "click favorites link; taken to favorites index page" do
    visit "/shelters/#{@shelter1.id}"
    click_link("Favorites: 2 pets")

    expect(current_path).to eq("/favorites")

    visit "/pets/#{@pet2.id}"
    click_link("Favorites: 2 pets")

    expect(current_path).to eq("/favorites")

    visit "/shelters/#{@shelter2.id}/pets"
    click_link("Favorites: 2 pets")

    expect(current_path).to eq("/favorites")

    visit "/pets"
    click_link("Favorites: 2 pets")

    expect(current_path).to eq("/favorites")
  end
end