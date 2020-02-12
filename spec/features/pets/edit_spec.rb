require "rails_helper"

describe 'As a visitor on the pet edit page' do
  before(:each) do
    @shelter1 = Shelter.create( name: "Bloke",
                                address: "123456 E. Koko St.",
                                city: "Aville",
                                state: "CO",
                                zip: "83504" )

    pet2_path = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"

    @pet1 = Pet.create( image: pet2_path,
                        name: "Shabba",
                        approximate_age: 5,
                        sex: "indigo",
                        shelter_id: @shelter1.id,
                        shelter_name: @shelter1.name,
                        description: "grumpy",
                        adoption_status: "adoptable" )

    visit "/pets/#{@pet1.id}/edit"
  end

  describe "I see a form to edit the pet" do
    it "and I can fill out that form" do
      fill_in 'pet_image', with: nil
      fill_in 'pet_name', with: 'Bowser'
      fill_in 'pet_description', with: 'no longer grumpy, now frumpy'
      fill_in 'pet_approximate_age', with: 6
      fill_in 'pet_sex', with: 'all day all day'
      click_button 'Update'

      expect(current_path).to eq("/pets/#{@pet1.id}")
      expect(page).to have_content(nil)
      expect(page).to have_content('Bowser')
      expect(page).to have_content('no longer grumpy, now frumpy')
      expect(page).to have_content(6)
      expect(page).to have_content('all day all day')

      expect(page).to_not have_content('Shabba')
      expect(page).to_not have_content(5)
      expect(page).to_not have_content('indigo')
    end

    it "I receive an error if I am missing any fields" do
      fill_in 'pet_image', with: nil
      fill_in 'pet_name', with: ''
      fill_in 'pet_description', with: ''
      fill_in 'pet_approximate_age', with: 6
      fill_in 'pet_sex', with: 'all day all day'
      click_button 'Update'

      expect(current_path).to eq("/pets/#{@pet1.id}/edit")
      expect(page).to have_content("Name can't be blank and Description can't be blank")
    end
  end

  it "I can see the header and footer" do
    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
