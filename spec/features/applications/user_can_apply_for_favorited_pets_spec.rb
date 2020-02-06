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
      expect(page).to have_css("#check-#{@pet1.id}")
      expect(page).to have_css("#check-#{@pet2.id}")
      expect(page).to have_field("Name")
      expect(page).to have_field("Address")
      expect(page).to have_field("City")
      expect(page).to have_field("State")
      expect(page).to have_field("Zip")
      expect(page).to have_field("Phone Number")
      expect(page).to have_field("Describe why you would make a good home:")
    end

    scenario "on app form, select all pets, fill out form, submit, and see submit message" do
      visit '/applications/new'

      find(:css, "#check-#{@pet1.id}").set(true)
      find(:css, "#check-#{@pet2.id}").set(true)

      fill_in "Name", with: "Heihachi"
      fill_in "Address", with: "1234 E. Tokyo St."
      fill_in "City", with: "Los Angeles"
      fill_in "State", with: "CA"
      fill_in "Zip", with: "90224"
      fill_in "Phone Number", with: "435-038-9879";
      fill_in "Describe why you would make a good home:", with: "I love pets."

      click_button "Submit Your Application"

      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Your application for the selected pets went through.")
      expect(page).not_to have_content(@pet1.name)

    end

    scenario "on app form, select one pet, fill out form, submit, and see submit message" do
      visit '/applications/new'

      find(:css, "#check-#{@pet1.id}").set(true)
      find(:css, "#check-#{@pet2.id}").set(false)

      fill_in "Name", with: "Heihachi"
      fill_in "Address", with: "1234 E. Tokyo St."
      fill_in "City", with: "Los Angeles"
      fill_in "State", with: "CA"
      fill_in "Zip", with: "90224"
      fill_in "Phone Number", with: "435-038-9879";
      fill_in "Describe why you would make a good home:", with: "I love pets."

      click_button "Submit Your Application"

      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Your application for the selected pets went through.")
      expect(page).not_to have_content(@pet1.name)
      expect(page).to have_content(@pet2.name)
    end

    scenario "select pet(s), dont fill out form fully, submit, and see error message" do
      visit '/applications/new'

      find(:css, "#check-#{@pet1.id}").set(true)
      find(:css, "#check-#{@pet2.id}").set(true)

      fill_in "Name", with: "Heihachi"
      fill_in "Address", with: "1234 E. Tokyo St."
      fill_in "City", with: ""
      fill_in "State", with: "CA"
      fill_in "Zip", with: "90224"
      fill_in "Phone Number", with: "435-038-9879";
      fill_in "Describe why you would make a good home:", with: ""

      click_button "Submit Your Application"

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("You must complete all fields in order for your application to be considered.")
    end
  end
end
