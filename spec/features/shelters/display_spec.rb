require 'rails_helper'

describe "As a visitor on the shelter's pets page" do
  before(:each) do
    @shelter1 = Shelter.create( name: "Broke Down but Cute",
                                address: "123456 E. Koko St.",
                                city: "Aville",
                                state: "CO",
                                zip: "83504" )

    @shelter2 = Shelter.create( name: "Are you lonely?",
                                address: "12765 E. Seesay St.",
                                city: "Aville",
                                state: "CO",
                                zip: "83571" )

    pet1_path = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"
    pet2_path = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"

    @pet1 = Pet.create( image: pet1_path,
                        name: "Patra",
                        approximate_age: 2,
                        sex: "free",
                        shelter_id: @shelter1.id,
                        shelter_name: @shelter1.name,
                        description: "cuddly",
                        adoption_status: "pending" )

    @pet2 = Pet.create( image: pet2_path,
                        name: "Shabba",
                        approximate_age: 5,
                        sex: "indigo",
                        shelter_id: @shelter1.id,
                        shelter_name: @shelter1.name,
                        description: "grumpy",
                        adoption_status: "adoptable")

    @pet3 = Pet.create( image: pet2_path,
                        name: "Violet",
                        approximate_age: 0,
                        sex: "male",
                        shelter_id: @shelter2.id,
                        shelter_name: @shelter2.name,
                        description: "happy",
                        adoption_status: "adoptable")

    visit "/shelters/#{@shelter1.id}/pets"
  end

  it "I can see the info for all pets" do
    expect(page).to have_content("All Pets for #{@shelter1.name}")
    expect(page).to have_link(@shelter1.name)
    expect(page).to have_content("Pet Count: We've got #{@shelter1.pet_count} pet(s).")
    expect(page).to_not have_content("All Pets for #{@shelter2.name}")
    expect(page).to_not have_link(@shelter2.name)
    expect(page).to_not have_content("Pet Count: We've got #{@shelter2.pet_count} pet(s).")

    expect(page).to have_link("Name: #{@pet1.name}")
    expect(page).to have_content("Approximate Age: #{@pet1.approximate_age}")
    expect(page).to have_content("Sex: #{@pet1.sex}")
    expect(page).to have_button("Edit #{@pet1.name}'s info!")
    expect(page).to have_button("Delete #{@pet1.name}")

    expect(page).to have_link("Name: #{@pet2.name}")
    expect(page).to have_content("Approximate Age: #{@pet2.approximate_age}")
    expect(page).to have_content("Sex: #{@pet2.sex}")
    expect(page).to have_button("Edit #{@pet2.name}'s info!")
    expect(page).to have_button("Delete #{@pet2.name}")

    expect(page).to_not have_content("Approximate Age: #{@pet3.approximate_age}")
    expect(page).to_not have_content("Sex: #{@pet3.sex}")
    expect(page).to_not have_button("Edit #{@pet3.name}'s info!")
    expect(page).to_not have_button("Delete #{@pet3.name}")
  end

  it "I can see the header and footer" do
    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
