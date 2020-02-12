require 'rails_helper'

describe 'As a visitor on the pet show page' do
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

    visit "/pets/#{@pet1.id}"
  end

  it "I can see all the pet info" do
    expect(page).to have_button("Favorite this pet.")
    expect(page).to have_content("Name: #{@pet1.name}")
    expect(page).to have_content("Description: #{@pet1.description}")
    expect(page).to have_content("Adoption Status: #{@pet1.adoption_status}")
    expect(page).to have_content("Approximate Age: #{@pet1.approximate_age}")
    expect(page).to have_content("Sex: #{@pet1.sex}")
    expect(page).to have_link("Update #{@pet1.name}'s information!")
    expect(page).to have_link("Delete #{@pet1.name}'s whole existence! Go ahead!")
    expect(page).to have_link("All Applications For This Pet")
    expect(page).to have_content("This pet has no holds.")

    visit "/pets/#{@pet1.id}"
    click_button("Favorite this pet.")

    visit "/favorites"
    click_link("Adopt Your Favorite Pets")

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

    visit "/pets/#{@pet1.id}/applications"
    click_link(name)
    click_link("Approve #{@pet1.name}'s application")

    visit "/pets/#{@pet1.id}"

    expect(page).to have_content("Adoption Status: pending")
    expect(page).to have_content("You cannot delete this pet while its application is approved.")
    expect(page).to_not have_link("Delete #{@pet1.name}'s whole existence! Go ahead!")
  end

  describe 'when I click the favorites button' do
    describe 'the button us removed from the pet page' do
      it 'and the pet is added to the favorites' do
        click_button("Favorite this pet.")

        expect(page).to have_button("Remove this pet from favorites.")
        expect(page).to_not have_button("Favorite this pet.")
        expect(page).to have_content("The pet has been added to your favorites list.")
        expect(page).to have_link("Favorites: 1 pet")

        visit "/favorites"

        expect(page).to have_content("Name: #{@pet1.name}")

        visit "/pets/#{@pet1.id}"

        click_button("Remove this pet from favorites.")
        expect(page).to have_content("The pet has been removed from your Favorite Pets.")
        expect(page).to have_link("Favorites: 0 pets")

        visit "/favorites"

        expect(page).to_not have_content("Name: #{@pet1.name}")
      end
    end
  end

  describe 'when I click to udpate the pets info' do
    it 'I am taken to the pet edit page' do
      click_link("Update #{@pet1.name}'s information!")
      expect(current_path).to eq("/pets/#{@pet1.id}/edit")
    end
  end

  describe 'when I click to delete the pets' do
    describe 'the pet is deleted' do
      it 'and I am taken to the pets index' do
        click_link("Delete #{@pet1.name}'s whole existence! Go ahead!")
        expect(current_path).to eq("/pets")
        expect(page).to_not have_content(@pet1.name)
      end
    end
  end

  describe 'when I click the applications link' do
    it 'I am taken to the applications page' do
      click_link("All Applications For This Pet")
      expect(current_path).to eq("/pets/#{@pet1.id}/applications")
    end
  end

  it "I can see the header and footer" do
    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
