require 'rails_helper'

describe "As a visitor on the shelter new page" do
  before :each do
    visit "/shelters/new"
  end

  describe "I can see the form to fill out a new shelter" do
    it "and fill out the form to create a new shelter" do
      expect(page).to have_content('Fill out this form for a new shelter!')
      fill_in "shelter_name", with: "Spot"
      fill_in "shelter_address", with: "5378 W. Curry St."
      fill_in "shelter_city", with: "Westminster"
      fill_in "shelter_state", with: "CO"
      fill_in "shelter_zip", with: "80019"
      click_button 'Submit'
      expect(current_path).to eq("/shelters")
      expect(page).to have_link("Spot")
      expect(page).to have_content("The shelter has been created!")
    end
  end

  it "it can display message if fields are missing" do
    fill_in "shelter_name", with: "Spot"
    fill_in "shelter_address", with: "5378 W. Curry St."
    fill_in "shelter_city", with: "Westminster"
    fill_in "shelter_state", with: "CO"
    click_button 'Submit'
    expect(page).to have_button("Submit")
    expect(page).to have_content("Zip can't be blank")
  end

  it "I can see the header and footer" do
    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
