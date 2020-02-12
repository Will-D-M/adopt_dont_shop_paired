require 'rails_helper'

describe "As a visitor on the favorites page" do
  before(:each) do
    @shelter1 = Shelter.create( name: "Bloke",
                                address: "123456 E. Koko St.",
                                city: "Aville",
                                state: "CO",
                                zip: "83504" )

    pet1_path = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"
    pet2_path = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"

    @pet1 = Pet.create( image: pet1_path,
                        name: "Patra",
                        approximate_age: 2,
                        sex: "free",
                        shelter_id: @shelter1.id,
                        shelter_name: @shelter1.name )

    @pet2 = Pet.create( image: pet2_path,
                        name: "Shabba",
                        approximate_age: 5,
                        sex: "indigo",
                        shelter_id: @shelter1.id,
                        shelter_name: @shelter1.name )
  end

  it "I can see all favorited pets with a name link and info" do
    visit "/pets/#{@pet1.id}"
    click_button("Favorite this pet.")
    visit "/favorites"

    pet1_path = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"

    within("#favorite#{@pet1.id}") do
      expect(page).to have_link("Name: #{@pet1.name}", href: "/pets/#{@pet1.id}")
      expect(page).to have_css("img[src*='#{pet1_path}']")
      click_link("Name: #{@pet1.name}")
      expect(current_path).to eq("/pets/#{@pet1.id}")
    end
  end

  it "I see a message regarding no favorited pets if none have been favorited" do
    visit '/favorites'
    expect(page).to have_content("You have not favorited any pets.")
    expect(page).to_not have_link("Name: #{@pet1.name}")
    expect(page).to_not have_link("Name: #{@pet2.name}")
    expect(page).to_not have_button("Remove this pet from favorites")
  end

  it "I can remove a pet from my favorites list" do
    visit "/pets/#{@pet1.id}"
    click_button("Favorite this pet.")
    visit "/favorites"

    within("#favorite#{@pet1.id}") do
      click_button("Remove this pet from favorites.")
      expect(current_path).to eq("/favorites")
    end

    expect(page).to_not have_link("Name: @pet1.name")
    expect(page).to_not have_css("img[src*='#{"https://images-ra.adoptapet.com/images/Homepage-DogV2.png"}']")
    expect(page).to have_content("The pet has been removed from your Favorite Pets.")
  end

  it "I can click a link to take me to the adoption application" do
    visit "/favorites"
    click_link("Adopt Your Favorite Pets")
    expect(current_path).to eq("/applications/new")
  end

  describe "I can see all pending applications for each pet" do
    it "and click the link to take me to the pet show page" do
      visit "/favorites"
      expect(page).to have_content("Pending Applications")
      expect(page).to_not have_link("Name: #{@pet1.name}")

      visit "/pets/#{@pet1.id}"
      click_button("Favorite this pet.")
      visit "/favorites"
      click_link("Adopt Your Favorite Pets")
      expect(current_path).to eq("/applications/new")

      find(:css, "#check-#{@pet1.id}").set(true)
      fill_in "Name", with: "Heihachi"
      fill_in "Address", with: "1234 E. Tokyo St."
      fill_in "City", with: "Los Angeles"
      fill_in "State", with: "CA"
      fill_in "Zip", with: "90224"
      fill_in "Phone Number", with: "435-038-9879";
      fill_in "Describe why you would make a good home:", with: "I love pets."

      click_button "Submit Your Application"

      expect(current_path).to eq("/favorites")

      expect(page).to have_link("Name: #{@pet1.name}")
      expect(page).to have_content("Your application for the selected pets went through.")
    end
  end

  it "I see a list of all pets with approved applications" do
    visit "/pets/#{@pet1.id}"
    click_button("Favorite this pet.")
    visit "/favorites"
    click_link("Adopt Your Favorite Pets")

    find(:css, "#check-#{@pet1.id}").set(true)
    fill_in "Name", with: "Heihachi"
    fill_in "Address", with: "1234 E. Tokyo St."
    fill_in "City", with: "Los Angeles"
    fill_in "State", with: "CA"
    fill_in "Zip", with: "90224"
    fill_in "Phone Number", with: "435-038-9879";
    fill_in "Describe why you would make a good home:", with: "I love pets."
    click_button "Submit Your Application"

    click_link("Name: #{@pet1.name}")
    click_link("All Applications For This Pet")
    click_link("Heihachi")
    click_link("Approve #{@pet1.name}'s application")
    visit '/favorites'

    within("#approved-applications") do
      expect(page).to have_link(@pet1.name)
    end
  end

  it "I can remove all favorited pets at once" do
    visit "/pets/#{@pet1.id}"
    click_button 'Favorite this pet.'
    visit "/pets/#{@pet2.id}"
    click_button 'Favorite this pet.'
    visit '/favorites'

    expect(page).to have_content("Name: #{@pet1.name}")
    expect(page).to have_content("Name: #{@pet2.name}")

    click_button("Remove All Pets from Favorites")

    expect(page).to have_content("You have not favorited any pets.")
    expect(page).to_not have_content("Name: #{@pet1.name}")
    expect(page).to_not have_content("Name: #{@pet2.name}")
  end

  it "I can see the header and footer" do
    visit '/favorites'

    page.should have_link('All Pets')
    page.should have_link('All Shelters')
    page.should have_link('Favorites: 0 pets')
    expect(page).to have_content("Thank you for visiting our site! Do not hesitate to contact us at 1-800-NOPE!")
  end
end
