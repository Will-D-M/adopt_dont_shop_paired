require "rails_helper"

RSpec.describe 'update pet info', type: :feature do
  before(:each) do
    @shelter1 = Shelter.create(name: "Bloke",
    address: "123456 E. Koko St.",
    city: "Aville",
    state: "CO",
    zip: "83504")
    @shelter2 = Shelter.create(name: "Stevie",
    address: "12765 E. Seesay St.",
    city: "Aville",
    state: "CO",
    zip: "83571")

    pet1_path = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"
    pet2_path = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"

    @pet1 = Pet.create(image: pet1_path,
    name: "Patra",
    approximate_age: 2,
    sex: "free",
    shelter_id: @shelter1.id,
    shelter_name: @shelter1.name,
    description: "cuddly",
    adoption_status: "pending")
    @pet2 = Pet.create(image: pet2_path,
    name: "Shabba",
    approximate_age: 5,
    sex: "indigo",
    shelter_id: @shelter1.id,
    shelter_name: @shelter1.name,
    description: "grumpy",
    adoption_status: "adoptable")
  end

  scenario "see link to update on pet show page" do
    visit "/pets/#{@pet2.id}"

    expect(page). to have_link("Update #{@pet2.name}'s information!")
  end

  scenario "see form on pet edit page" do
    visit "/pets/#{@pet2.id}/edit"

    expect(page).to have_field('pet_image')
    expect(page).to have_field('pet_name')
    expect(page).to have_field('pet_description')
    expect(page).to have_field('pet_approximate_age')
    expect(page).to have_field('pet_sex')
    expect(page).to have_button('Update')
  end

  scenario "fill out/submit form, and get redirected to pet show page" do
    visit "/pets/#{@pet2.id}/edit"

    fill_in 'pet_image', with: nil
    fill_in 'pet_name', with: 'Bowser'
    fill_in 'pet_description', with: 'no longer grumpy, now frumpy'
    fill_in 'pet_approximate_age', with: 6
    fill_in 'pet_sex', with: 'all day all day'
    click_button 'Update'

    expect(current_path).to eq("/pets/#{@pet2.id}")
    expect(page).to have_content(nil)
    expect(page).to have_content('Bowser')
    expect(page).to have_content('no longer grumpy, now frumpy')
    expect(page).to have_content(6)
    expect(page).to have_content('all day all day')
  end

end
