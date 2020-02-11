require 'rails_helper'

describe "As a visitor on the welcome index page" do
  describe "there is a link to the pet index" do
    it "that takes me to the pet index" do
      visit "/"
      click_link("All Pets")
      expect(current_path).to eq("/pets")
    end
  end

  describe "there is a link to the shelters index" do
    it "that takes me to the shelters index" do
      visit "/"
      click_link("All Shelters")
      expect(current_path).to eq("/shelters")
    end
  end

  describe "there is a link to the favorites index" do
    it "that takes me to the favorites index" do
      visit "/"
      click_link("Favorites: 0 pets")
      expect(current_path).to eq("/favorites")
    end
  end

  it "I see a welcome message, image, and footer" do
    visit "/"
    expect(page).to have_content("Welcome to Adopt, Don't Shop!")
    expect(page).to have_content("Thank you for visiting our site!")
    expect(page).to have_content("You can access all of our shelters and/or all of our pets through the links above.")
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
    expect(page).to have_css("img[src*='#{"https://d17fnq9dkz9hgj.cloudfront.net/uploads/2018/01/shutterstock_587562362.jpg"}']")
  end
end
