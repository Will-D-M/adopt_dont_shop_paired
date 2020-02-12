require 'rails_helper'

describe 'As a visitor on the pets index page' do
  before :each do
    @shelter1 = Shelter.create( name: "Bloke",
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
                        adoption_status: "adoptable" )

    visit "/pets"
  end

  it 'I can see all pets and their info' do
    expect(page).to have_content("All Pets")

    within("#pet#{@pet1.id}") do
      expect(page).to have_link("Name: #{@pet1.name}")
      expect(page).to have_content("Approximate Age: #{@pet1.approximate_age}")
      expect(page).to have_content("Sex: #{@pet1.sex}")
      expect(page).to have_button("Edit #{@pet1.name}'s info!")
      expect(page).to have_button("Delete #{@pet1.name}")
    end

    within("#pet#{@pet2.id}") do
      expect(page).to have_link("Name: #{@pet2.name}")
      expect(page).to have_content("Approximate Age: #{@pet2.approximate_age}")
      expect(page).to have_content("Sex: #{@pet2.sex}")
      expect(page).to have_button("Edit #{@pet2.name}'s info!")
      expect(page).to have_button("Delete #{@pet2.name}")
    end
  end

  describe 'when I click their name' do
    it 'I am dericted to the pet show page' do
      click_link("Name: #{@pet1.name}")
      expect(current_path).to eq("/pets/#{@pet1.id}")
    end
  end

  describe 'when I click the edit button' do
    it 'I am dericted to the pet edit page' do
      click_button("Edit #{@pet1.name}'s info!")
      expect(current_path).to eq("/pets/#{@pet1.id}/edit")
    end
  end

  describe 'when I click the delete button' do
    it 'the pet is removed from the page' do
      click_button("Delete #{@pet1.name}")
      expect(current_path).to eq("/pets")

      expect(page).to_not have_content("Patra")
      expect(page).to_not have_content("cuddly")
      expect(page).to_not have_content("free")
    end
  end

  it "I can see the header and footer" do
    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
