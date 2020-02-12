require 'rails_helper'

describe 'As a visitor on the applications index page' do
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

    visit "/pets/#{@pet1.id}"
    click_button("Favorite this pet.")

    visit "/favorites"
    click_link("Adopt Your Favorite Pets")

    find(:css, "#check-#{@pet1.id}").set(true)
    fill_in "Name", with: "Heihachi"
    fill_in "Address", with: "1234 E. Tokyo St."
    fill_in "City", with: "Los Angeles"
    fill_in "State", with: "CA"
    fill_in "Zip", with: "90224"
    fill_in "Phone Number", with: "435-038-9879";
    fill_in "Describe why you would make a good home:", with: "I love pets."

    click_button "Submit Your Application"

    visit "/pets/#{@pet1.id}"
    click_button("Favorite this pet.")
    visit "/favorites"
    click_link("Adopt Your Favorite Pets")

    find(:css, "#check-#{@pet1.id}").set(true)
    fill_in "Name", with: "Pepe"
    fill_in "Address", with: "4534 E. July Ct."
    fill_in "City", with: "Memphis"
    fill_in "State", with: "TN"
    fill_in "Zip", with: "38113"
    fill_in "Phone Number", with: "901-044-5564";
    fill_in "Describe why you would make a good home:", with: "I need company."
    click_button "Submit Your Application"

    visit "/pets/#{@pet1.id}/applications"
  end

  describe 'I can see a link for each application' do
    it 'and click that link' do
      expect(page).to have_content("All Applicants:")
      expect(page).to have_link("Heihachi")
      expect(page).to have_link("Pepe")

      @application = Application.all.first

      click_link("Heihachi")
      expect(current_path).to eq("/applications/#{@application.id}")
    end
  end

  it "I can see the header and footer" do
    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
