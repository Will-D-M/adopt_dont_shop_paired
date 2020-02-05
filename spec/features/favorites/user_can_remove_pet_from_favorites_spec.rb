require 'rails_helper'

describe "As a visitor" do
  describe "I can remove a pet from my favorite pets" do
    describe "by clicking on the remove from favorite pets button" do
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
        sex: "female",
        shelter_id: @shelter1.id,
        shelter_name: @shelter1.name)
      end

      it "displays a message indicating the pet was removed" do
        visit "/pets/#{@pet1.id}"

        click_button('Favorite this pet.')

        click_button('Remove this pet from favorites')

        expect(current_path).to eq("/pets/#{@pet1.id}")

        expect(page).to have_content("#{@pet1.name} has been removed from your Favorite Pets.")
      end

      it "changes the remove from favorites button to add to favorites" do
        visit "/pets/#{@pet1.id}"

        click_button 'Add to Favorite Pets'

        click_button 'Remove this pet from favorites'

        expect(page).to have_button('Add to Favorite Pets')
      end

      it "decreases the favorites number by 1" do
        visit "/pets/#{@pet1.id}"

        click_button 'Add to Favorite Pets'

        expect(page).to have_content('Favorites: 1 Pets')

        click_button 'Remove this pet from favorites'

        expect(page).to have_content('Favorites: 0 Pets')
      end
    end
  end
end
