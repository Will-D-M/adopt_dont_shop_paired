require 'rails_helper'

describe 'As a visitor on the shelter show page' do
  before :each do
    @shelter1 = Shelter.create( name: "Bloke",
                                address: "123456 E. Koko St.",
                                city: "Aville",
                                state: "CO",
                                zip: "83504" )

    @shelter2 = Shelter.create( name: "Stevie",
                                address: "12765 E. Seesay St.",
                                city: "Aville",
                                state: "CO",
                                zip: "83571" )

    pet1_path = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"

    @pet1 = Pet.create( image: pet1_path,
                        name: "Patra",
                        approximate_age: 2,
                        sex: "free",
                        shelter_id: @shelter1.id,
                        shelter_name: @shelter1.name )

    @review1 = Review.create( title: "Good",
                              rating: 5,
                              content: "I found my new best friend",
                              picture: "https://images-ra.adoptapet.com/images/Homepage-DogV2.png",
                              shelter_id: "#{@shelter1.id}" )

    visit "/shelters/#{@shelter1.id}"
  end

  it "I can see the shelter info" do
    expect(page).to have_content("Name: #{@shelter1.name}")
    expect(page).to have_content("Address: #{@shelter1.address}")
    expect(page).to have_content("City: #{@shelter1.city}")
    expect(page).to have_content("State: #{@shelter1.state}")
    expect(page).to have_content("Zip: #{@shelter1.zip}")
    expect(page).to have_content("Number of pets at this shelter: #{@shelter1.pet_count}")
    expect(page).to have_content("Number of applications on file for pets at this shelter: #{@shelter1.number_of_applications}")
    expect(page).to have_content("Average Rating: #{@shelter1.average_rating} / 5")
    expect(page).to_not have_content("Name: #{@shelter2.name}")
  end

  describe "there is a link to update the shelter" do
    it "that will take me to the shelter edit page" do
      click_link "Update Shelter"
      expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")
    end
  end

  describe "there is a button to delete the shelter" do
    it "that will delete the shelter from the app" do
      click_button "Delete #{@shelter1.name}"
      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content(@shelter1.name)
    end
  end

  describe "if the shelter has pets that are pending adoption" do
    it "I cannot see a button to delete that shelter" do
      visit "/pets/#{@pet1.id}"
      click_button 'Favorite this pet.'

      visit '/applications/new'

      name = "Heihachi"

      find(:css, "#check-#{@pet1.id}").set(true)
      fill_in "Name", with: name
      fill_in "Address", with: "1234 E. Tokyo St."
      fill_in "City", with: "Los Angeles"
      fill_in "State", with: "CA"
      fill_in "Zip", with: "90224"
      fill_in "Phone Number", with: "435-038-9879";
      fill_in "Describe why you would make a good home:", with: "I love pets."

      click_button "Submit Your Application"

      visit "pets/#{@pet1.id}"

      click_link 'All Applications For This Pet'

      click_link "#{name}"

      click_link "Approve #{@pet1.name}'s application"

      visit "/shelters/#{@shelter1.id}"

      expect(page).to_not have_button("Delete #{@shelter1.name}")
    end
  end

  describe "there is a link to the shelter pets" do
    it "that will take me to the shelters pets page" do
      click_link "Pets"
      expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")
    end
  end

  describe "there is a link to add a review" do
    it "that will take me to the shelter review page" do
      click_link "Add Review"
      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
    end
  end

  it "I can see all reviews" do
    expect(current_path).to eq("/shelters/#{@shelter1.id}")
    expect(page).to have_content("Good")
    expect(page).to have_content(5)
    expect(page).to have_content("I found my new best friend")
    expect(page).to have_css("img[src*='#{"https://images-ra.adoptapet.com/images/Homepage-DogV2.png"}']")
  end

  it "I can edit reviews" do
    click_link("Edit this review!")
    expect(current_path).to eq("/shelters/#{@review1.id}/reviews/edit")
  end

  it "I can delete reviews" do
    click_link("Delete this review!")
    expect(current_path).to eq("/shelters/#{@shelter1.id}")
    expect(page).to_not have_content("Good")
    expect(page).to_not have_content("I found my new best friend")
    expect(page).to_not have_css("img[src*='#{"https://images-ra.adoptapet.com/images/Homepage-DogV2.png"}']")
  end

  it "I can see the header and footer" do
    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
