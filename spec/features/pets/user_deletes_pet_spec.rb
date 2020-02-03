require 'rails_helper'

RSpec.describe "deletes pet", type: :feature do
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
    shelter_id: @shelter2.id,
    shelter_name: @shelter2.name,
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

  scenario "see pet info and button that deletes shelter" do
    visit "/pets"
    link = "/pets/#{@pet1.id}"

    expect(page).to have_link('Patra', href: link)

    click_link('Patra')

    expect(current_path).to eq(link)
    expect(page).to have_css("img[src*='#{@pet1.image}']")
    expect(page).to have_content("Patra")
    expect(page).to have_content(2)
    expect(page).to have_content("cuddly")
    expect(page).to have_content("free")
    expect(page).to have_content("pending")
    expect(page).to have_link("Delete Patra's whole existence! Go ahead!")
  end

  scenario "click delete button and see pet removed from index" do
    visit "/pets/#{@pet1.id}"
    click_link("Delete Patra's whole existence! Go ahead!")

    expect(current_path).to eq("/pets")
    expect(page).not_to have_link('Patra', href:  "/pets/#{@pet1.id}")
  end
end
