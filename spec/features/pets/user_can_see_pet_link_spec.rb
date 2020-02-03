require 'rails_helper'

RSpec.describe "pet link", type: :feature do
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
    shelter_name: @shelter1.name,
    description: "cuddly",
    adoption_status: "pending")
    @pet2 = Pet.create(image: pet2_path,
    name: "Shabba",
    approximate_age: 5,
    sex: "indigo",
    shelter_id: @shelter2.id,
    shelter_name: @shelter2.name,
    description: "grumpy",
    adoption_status: "adoptable")
  end

  scenario "clicks pet name link to pet show page" do
    visit "/pets"
    click_link("#{@pet1.name}")

    expect(current_path).to eq("/pets/#{@pet1.id}")
  end

  scenario "clicks pet name link to pet show page" do
    visit "/pets"
    click_link("#{@pet2.name}")

    expect(current_path).to eq("/pets/#{@pet2.id}")
  end

  scenario "clicks pet name link to pet show page" do
    visit "/shelters/#{@shelter1.id}/pets"
    click_link("#{@pet1.name}")

    expect(current_path).to eq("/pets/#{@pet1.id}")
  end

  scenario "clicks pet name link to pet show page" do
    visit "/shelters/#{@shelter2.id}/pets"
    click_link("#{@pet2.name}")

    expect(current_path).to eq("/pets/#{@pet2.id}")
  end
end
