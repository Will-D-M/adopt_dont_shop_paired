require 'rails_helper'

describe 'As a visitor on the shelters index page'  do
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

    visit "/shelters"
  end

  describe "I can see a a link to all shelters" do
    it "that will take me to the shelter's show page" do
      expect(page).to have_link(@shelter1.name)
      expect(page).to have_link(@shelter2.name)
      click_link(@shelter1.name)
      expect(current_path).to eq("/shelters/#{@shelter1.id}")
    end
  end

  describe "I can see a button to edit each shelter" do
    it "that will take me to the shelter's edit page" do
      expect(page).to have_button("Edit #{@shelter1.name}")
      expect(page).to have_button("Edit #{@shelter2.name}")
      click_button("Edit #{@shelter1.name}")
      expect(current_path).to eq("/shelters/#{@shelter1.id}/edit")
    end
  end

  describe "I can see a button to delete each shelter" do
    it "that will remove the shelter from the app" do
      expect(page).to have_button("Delete #{@shelter1.name}")
      expect(page).to have_button("Delete #{@shelter2.name}")
      click_button("Delete #{@shelter1.name}")
      expect(current_path).to eq("/shelters")
      expect(page).to_not have_content(@shelter1.name)
    end
  end

  describe "I can see a link to create new shelter" do
    it "that will take me to the new shelters page" do
      click_link('Create New Shelter')
      expect(current_path).to eq("/shelters/new")
    end
  end

  describe "if a shelter has pets that are pending adoption" do
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

      visit "/shelters"

      expect(page).to_not have_button("Delete #{@shelter1.name}")
    end
  end

  it "I can see the header and footer" do
    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
