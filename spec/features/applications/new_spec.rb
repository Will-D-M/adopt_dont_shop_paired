require 'rails_helper'

describe "As a visitor on the new application page" do
  before(:each) do
    @shelter1 = Shelter.create( name: "Bloke",
                                address: "123456 E. Koko St.",
                                city: "Aville",
                                state: "CO",
                                zip: "83504" )

    pet1_path = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"
    pet2_path = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"

    @pet1 = Pet.create( image: pet1_path,
                        name: "Patra",
                        approximate_age: 2,
                        sex: "free",
                        shelter_id: @shelter1.id,
                        shelter_name: @shelter1.name )

    @pet2 = Pet.create( image: pet2_path,
                        name: "Shabba",
                        approximate_age: 5,
                        sex: "indigo",
                        shelter_id: @shelter1.id,
                        shelter_name: @shelter1.name )

    visit "/pets/#{@pet1.id}"
    click_button("Favorite this pet.")
    visit "/pets/#{@pet2.id}"
    click_button("Favorite this pet.")

    visit '/applications/new'
  end

  describe 'I can see a form to fill out an application' do
    it 'and I can submit that form' do
      expect(page).to have_content("Adoption Application")
      expect(page).to have_content("Select the pets you want to apply for:")

      find(:css, "#check-#{@pet1.id}").set(true)
      find(:css, "#check-#{@pet2.id}").set(false)

      fill_in "Name", with: "Heihachi"
      fill_in "Address", with: "1234 E. Tokyo St."
      fill_in "City", with: "Los Angeles"
      fill_in "State", with: "CA"
      fill_in "Zip", with: "90224"
      fill_in "Phone Number", with: "435-038-9879";
      fill_in "Describe why you would make a good home:", with: "I love pets."

      click_button "Submit Your Application"

      expect(current_path).to eq("/favorites")
      expect(page).to have_content("Your application for the selected pets went through.")
    end

    it 'and receive an error message if any fields are missing' do
      find(:css, "#check-#{@pet1.id}").set(true)
      find(:css, "#check-#{@pet2.id}").set(true)

      fill_in "Name", with: "Heihachi"
      fill_in "Address", with: "1234 E. Tokyo St."
      fill_in "City", with: ""
      fill_in "State", with: "CA"
      fill_in "Zip", with: "90224"
      fill_in "Phone Number", with: "435-038-9879";

      click_button "Submit Your Application"

      expect(current_path).to eq("/applications/new")
      expect(page).to have_content("You must complete all fields in order for your application to be considered.")
    end
  end

end
