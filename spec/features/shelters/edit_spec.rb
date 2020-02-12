require 'rails_helper'

describe "As a visitor on the shelter edit page" do
  before :each do
    @shelter1 = Shelter.create( name: "Bloke",
                                address: "123456 E. Koko St.",
                                city: "Aville",
                                state: "CO",
                                zip: "83504" )

    visit "/shelters/#{@shelter1.id}/edit"
  end

  describe "I can see a form to edit the shelter" do
    it "and I can fill out that form to update the shelter" do

      expect(page).to have_content('Fill out this form to update a shelter!')
      fill_in "shelter_name", with: "Updated"
      fill_in "shelter_address", with: "Updated St."
      fill_in "shelter_city", with: "Updated City"
      fill_in "shelter_state", with: "CO"
      fill_in "shelter_zip", with: "80309"
      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{@shelter1.id}")
      expect(page).to have_content("Updated")
      expect(page).to have_content("Updated St.")
      expect(page).to have_content("Updated City")
      expect(page).to have_content("CO")
      expect(page).to have_content("80309")
    end
  end

  it "it gives me a message if fields are missing" do
    visit "/shelters/#{@shelter1.id}/edit"

    fill_in "shelter_address", with: "Updated St."
    fill_in "shelter_city", with: "Updated City"
    fill_in "shelter_state", with: "CO"
    fill_in "shelter_zip", with: "80309"
    click_button 'Submit'

    expect(page).to have_button("Submit")
    expect(page).to have_content("Name can't be blank")
  end

  it "I can see the header and footer" do
    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
