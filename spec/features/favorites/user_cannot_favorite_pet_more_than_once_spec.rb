require 'rails_helper'

describe 'When visiting a pet show page' do
  describe 'if a pet has already been favorited' do
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

    it "the button to favorite a pet on it's show page is replaced by a button to remove from favorites" do
      visit "/pets/#{@pet1.id}"

      click_button('Favorite this pet.')

      expect(page).to_not have_button('Favorite this pet')

      expect(page).to have_button('Remove this pet from favorites')
    end
  end
end
