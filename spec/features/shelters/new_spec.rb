require 'rails_helper'

describe "As a visitor on the shelter new page" do
  before :each do
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

    visit "/shelters/new"
  end

  describe "I can see the form to fill out a new shelter" do
    it "and fill out the form to create a new shelter" do
      expect(page).to have_content('Fill out this form for a new shelter!')
      fill_in "shelter_name", with: "Spot"
      fill_in "shelter_address", with: "5378 W. Curry St."
      fill_in "shelter_city", with: "Westminster"
      fill_in "shelter_state", with: "CO"
      fill_in "shelter_zip", with: "80019"
      click_button 'Submit'
      expect(current_path).to eq("/shelters")
      expect(page).to have_link("Spot")
      expect(page).to have_content("The shelter has been created!")
    end
  end

  it "it can display message if fields are missing" do
    fill_in "shelter_name", with: "Spot"
    fill_in "shelter_address", with: "5378 W. Curry St."
    fill_in "shelter_city", with: "Westminster"
    fill_in "shelter_state", with: "CO"
    click_button 'Submit'
    expect(page).to have_button("Submit")
    expect(page).to have_content("Zip can't be blank")
  end

  it "I can see the header and footer" do
    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
