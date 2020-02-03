require 'rails_helper'

RSpec.describe "pets index", type: :feature do
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
    shelter_id: @shelter1.id,
    shelter_name: @shelter1.name)
  end

  scenario "sees link for and can click to pets page" do
    visit "/shelters/#{@shelter1.id}"

    click_link("Pets")

    expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
    expect(page).to have_content("Patra")
    expect(page).to have_content("Shabba")

    visit "/shelters/#{@shelter2.id}"

    click_link("Pets")

    expect(current_path).to eq("/shelters/#{@shelter2.id}/pets")
    expect(page).not_to have_content("Patra")
    expect(page).not_to have_content("Shabba")
  end

  scenario "sees all pet information on shelter's pets page" do
    visit "/shelters/#{@shelter1.id}/pets"

    expect(page).to have_content('All Pets for "Bloke"')
    expect(page).to have_css("img[src*='#{@pet1.image}']")
    expect(page).to have_content("Patra")
    expect(page).to have_content(2)
    expect(page).to have_content("free")
    expect(page).to have_css("img[src*='#{@pet2.image}']")
    expect(page).to have_content("Shabba")
    expect(page).to have_content(5)
    expect(page).to have_content("indigo")
  end

  scenario "sees edit button next to each pet" do
    visit "/shelters/#{@shelter1.id}/pets"

    expect(page).to have_button("Edit #{@pet1.name}'s info!")
    expect(page).to have_button("Edit #{@pet2.name}'s info!")
  end

  scenario "clicks edit button and sees update form" do
    visit "/shelters/#{@shelter1.id}/pets"
    click_button("Edit #{@pet1.name}'s info!")

    expect(current_path).to eq("/pets/#{@pet1.id}/edit")
    expect(page).to have_field('pet_image')
    expect(page).to have_field('pet_name')
    expect(page).to have_field('pet_description')
    expect(page).to have_field('pet_approximate_age')
    expect(page).to have_field('pet_sex')
    expect(page).to have_button('Update')
  end

  scenario "sees delete button next to each pet" do
    visit "/shelters/#{@shelter1.id}/pets"

    expect(page).to have_button("Delete #{@pet1.name}")
    expect(page).to have_button("Delete #{@pet2.name}")
  end

  scenario "clicks delete button and removes pet from index page" do
    visit "/shelters/#{@shelter1.id}/pets"
    click_button("Delete #{@pet1.name}")

    expect(current_path).to eq("/pets")
    expect(page).not_to have_link('Patra', href:  "/pets/#{@pet1.id}")
  end

  scenario "shows a count of number of pets at this shelter" do
    visit "/shelters/#{@shelter1.id}/pets"

    expect(page).to have_content("We've got 2 pet(s).")

    visit "/shelters/#{@shelter2.id}/pets"

    expect(page).to have_content("We've got 0 pet(s).")
  end

end
