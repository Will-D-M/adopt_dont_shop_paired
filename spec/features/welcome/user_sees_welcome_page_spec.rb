require 'rails_helper'

RSpec.describe "shelters welcome", type: feature do
  it "sees welcome message and image" do
    visit "/"

    expect(page).to have_content("Welcome to Adopt, Don't Shop!")
    expect(page).to have_content("Thank you for visiting our site!")
  end

  it "sees links to pets and shelters" do
    visit "/"

    expect(page).to have_link("All Shelters")
    expect(page).to have_link("All Pets")
  end

  it "clicks link and goes to shelters" do
    visit "/"
    click_link "All Shelters"

    expect(current_path).to eq('/shelters')
  end

  it "clicks link and goes to pets" do
    visit "/"
    click_link "All Pets"

    expect(current_path).to eq('/pets')
  end
end
