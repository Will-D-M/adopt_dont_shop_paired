# User Story 16, Applying for a Pet
#
# As a visitor
# When I have added pets to my favorites list
# And I visit my favorites page ("/favorites")
# I see a link for adopting my favorited pets
# When I click that link I'm taken to a new application form
# At the top of the form, I can select from the pets of which I've favorited for which I'd like this application to apply towards (can be more than one)
# When I select one or more pets, and fill in my
# - Name
# - Address
# - City
# - State
# - Zip
# - Phone Number
# - Description of why I'd make a good home for this/these pet(s)
# And I click on a button to submit my application
# I see a flash message indicating my application went through for the pets that were selected
# And I'm taken back to my favorites page where I no longer see the pets for which I just applied listed as favorites

require 'rails_helper'

RSpec.describe 'apply for pet' do
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

  scenario "favorites page has adopt link" do
    visit "/favorites"

    expect(page).to have_link("Adopt Your Favorite Pets")
  end

  describe "pets have been added to favorites list" do
    scenario "on favorites page, click adopt link, taken to app form" do
      visit "/favorites"
      click_link("Adopt Your Favorite Pets")

      expect(current_path).to eq('/applications/new')
      expect(page).to have_css("#check-#{@pet1.name}")
      expect(page).to have_css("#check-#{@pet2.name}")
      expect(page).to have_field("Name")
      expect(page).to have_field("Address")
      expect(page).to have_field("City")
      expect(page).to have_field("State")
      expect(page).to have_field("Zip")
      expect(page).to have_field("Phone Number")
      expect(page).to have_field("Describe why you would make a good home:")
    end

    scenario "on app form, select pet(s), fill out form, submit, and see flash message" do
      visit '/applications/new'

      find(:css, "#check-#{@pet1.name}").set(true) #to check box
      find(:css, "#check-#{@pet2.name}").set(true)

      fill_in "Name", with: "Heihachi"
      fill_in "Address", with: "1234 E. Tokyo St."
      fill_in "City", with: "Los Angeles"
      fill_in "State", with: "CA"
      fill_in "Zip", with: "90224"
      fill_in "Phone Number", with: "435-038-9879";
      fill_in "Describe why you would make a good home:", with: "I love pets."

      click_button "Submit Your Application"

      #expect(current_path).to eq("/favorites")
    end

      # find(:css, "#check-#{@pet1.name}").set(true) # to check the box
      # find(:css, "#check-#{@pet1.name}").set(true) # to uncheck the box
      # save_and_open_page

      #need to set up many to many relationship between application, pet_app + pets
      #pet_app has to belong to both pet and application
      #application has to have both many pet_apps and pets through pet_apps
  end
end
