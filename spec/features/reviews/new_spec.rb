require 'rails_helper'

describe "As a visitor on the review new page" do
  describe "I see a form to fill out a new review" do
    before :each do
      @shelter1 = Shelter.create( name: "Mike's Shelter",
                                  address: "1331 17th Street",
                                  city: "Denver",
                                  state: "CO",
                                  zip: "80202")

      @title = "Horrible"
      @rating = 1
      @content = "I kicked that dog out."
      @picture = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"

      visit "/shelters/#{@shelter1.id}/reviews/new"
    end

    it "and I can fill out that form" do
      fill_in 'Title', with: @title
      select @rating, from: 'Rating'
      fill_in 'Content', with: @content
      fill_in 'Picture', with: @picture

      click_button('Submit')

      expect(current_path).to eq("/shelters/#{@shelter1.id}")
    end

    it 'I see an error message if I submit without required fields' do
      select @rating, from: 'Rating'
      fill_in 'Content', with: @content
      fill_in 'Picture', with: @picture

      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
      expect(page).to have_content("Please fill out all required fields.")

      fill_in 'Title', with: @title
      select @rating, from: 'Rating'
      fill_in 'Picture', with: @picture

      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{@shelter1.id}/reviews/new")
      expect(page).to have_content("Please fill out all required fields.")

      fill_in 'Title', with: @title
      fill_in 'Content', with: @content

      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{@shelter1.id}")
    end

    it "I can see the header and footer" do
      page.should have_link('All Pets')
      page.should have_link('All Shelters')
      page.should have_link('Favorites: 0 pets')
      expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
    end
  end
end
