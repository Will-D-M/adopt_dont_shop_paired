require 'rails_helper'

describe "As a visitor on the pets new page" do
  before(:each) do
    @shelter1 = Shelter.create(name: "Broke Down but Cute",
    address: "123456 E. Koko St.",
    city: "Aville",
    state: "CO",
    zip: "83504")

    pet1_path = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"

    @pet1 = Pet.create( image: pet1_path,
                        name: "Patra",
                        approximate_age: 2,
                        sex: "free",
                        shelter_id: @shelter1.id,
                        shelter_name: @shelter1.name,
                        description: "cuddly",
                        adoption_status: "pending" )

    visit "/shelters/#{@shelter1.id}/pets/new"
  end

  describe 'I see a form to fill out a new pet' do
    it 'and can fill out that form to create new pet' do
      expect(page).to have_content("Fill out this form to add a new pet!")
      fill_in "pet_name", with: "Medgar"
      fill_in "pet_description", with: "funny"
      fill_in "pet_approximate_age", with: 1
      fill_in "pet_sex", with: "flowersandrainbows"
      click_button 'Add a Pet'

      expect(current_path).to eq("/shelters/#{@shelter1.id}/pets")

      expect(page).to have_content("The pet has been created.")

      within("#pet#{@pet1.id}") do
        expect(page).to have_link("Name: #{@pet1.name}")
        expect(page).to have_content("Approximate Age: #{@pet1.approximate_age}")
        expect(page).to have_content("Sex: #{@pet1.sex}")
        expect(page).to have_button("Edit #{@pet1.name}'s info!")
        expect(page).to have_button("Delete #{@pet1.name}")
      end
    end

    it 'gives me an error message if I am missing any fields' do
      fill_in "pet_name", with: "Medgar"
      fill_in "pet_approximate_age", with: 1
      click_button 'Add a Pet'

      expect(current_path).to eq("/shelters/#{@shelter1.id}/pets/new")
      expect(page).to have_content("Sex can't be blank and Description can't be blank")
    end
  end

  it "I can see the header and footer" do
    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
