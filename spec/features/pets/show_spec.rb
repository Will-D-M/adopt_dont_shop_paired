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
  end

  describe 'when I click the favorites button' do
    describe 'the button us removed from the pet page' do
      it 'and the pet is added to the favorites' do
        click_button("Favorite this pet.")

        expect(page).to have_button("Remove this pet from favorites.")
        expect(page).to_not have_button("Favorite this pet.")
        expect(page).to have_content("The pet has been added to your favorites list.")

        visit "/favorites"

        expect(page).to have_content("Name: #{@pet1.name}")

        visit "/pets/#{@pet1.id}"

        click_button("Remove this pet from favorites.")
        expect(page).to have_content("The pet has been removed from your Favorite Pets.")

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

end
