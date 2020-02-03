require 'rails_helper'

RSpec.describe "shelters index", type: :feature do
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
  end

  it "displays all shelter names" do
    visit "/shelters"

    expect(page).to have_content(@shelter1.name)
    expect(page).to have_content(@shelter2.name)
  end

  scenario "sees edit shelter button" do
    visit "/shelters"

    expect(page).to have_button("Edit #{@shelter1.name}")
    expect(page).to have_button("Edit #{@shelter2.name}")
  end

  scenario "can click button and go to edit page" do
    visit "/shelters"
    link1 = "/shelters/#{@shelter1.id}/edit"
    click_button("Edit #{@shelter1.name}")

    expect(current_path).to eq(link1)
  end

  scenario "can click button and delete shelter" do
    visit "/shelters"
    click_button("Delete #{@shelter1.name}")

    expect(current_path).to eq("/shelters")
    expect(page).to_not have_content("Bloke")
  end
end
