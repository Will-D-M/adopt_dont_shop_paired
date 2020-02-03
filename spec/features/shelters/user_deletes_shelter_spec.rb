require 'rails_helper'

RSpec.feature "delete shelter", type: :feature do
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

  scenario "see and click link that deletes shelter" do
    visit "/shelters"
    link1 = "/shelters/#{@shelter1.id}"

    expect(page).to have_link("Bloke", href: link1)

    visit "/shelters/#{@shelter1.id}"

    expect(page).to have_content("Bloke")
    expect(page).to have_content("123456 E. Koko St.")
    expect(page).to have_content("Aville")
    expect(page).to have_content("CO")
    expect(page).to have_content("83504")

    click_link("Delete Shelter")

    expect(current_path).to eq("/shelters")
    expect(page).not_to have_link("Bloke")
  end
end
