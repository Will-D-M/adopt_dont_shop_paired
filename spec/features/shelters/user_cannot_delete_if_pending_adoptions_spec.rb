require 'rails_helper'

describe "As a visitor", type: :feature do
  before(:each) do
    @shelter1 = Shelter.create(name: "Bloke",
    address: "123456 E. Koko St.",
    city: "Aville",
    state: "CO",
    zip: "83504")

    pet1_path = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"

    @pet1 = Pet.create(image: pet1_path,
    name: "Patra",
    approximate_age: 2,
    sex: "free",
    shelter_id: @shelter1.id,
    shelter_name: @shelter1.name,
    description: "cuddly",
    adoption_status: "adoptable")
  end

  describe "If a shelter has pets that are pending adoption" do
    it "I cannot see a button to delete that shelter on its show page" do

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
end
