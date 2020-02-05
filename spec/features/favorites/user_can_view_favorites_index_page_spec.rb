require 'rails_helper'

RSpec.describe 'favorites index page', type: :feature do
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
    shelter_name: @shelter1.name)
    @pet2 = Pet.create(image: pet2_path,
    name: "Shabba",
    approximate_age: 5,
    sex: "indigo",
    shelter_id: @shelter2.id,
    shelter_name: @shelter2.name)

    title = "Good"
    rating = 5
    content = "I found my new best friend"
    picture = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"
    @review1 = Review.create(title: title, rating: rating, content: content, picture: picture, shelter_id: "#{@shelter1.id}")

    title2 = "Horrible"
    rating2 = 1
    content2 = "I kicked that dog out."
    picture2 = "https://previews.123rf.com/images/plysuikvv/plysuikvv1606/plysuikvv160600106/60811009-enraged-aggressive-angry-dog-grin-jaws-with-fangs-hungry-drool-.jpg"
    @review2 = Review.create(title: title2, rating: rating2, content: content2, picture: picture2, shelter_id: "#{@shelter2.id}")
    visit "/pets/#{@pet1.id}"
    click_button("Favorite this pet.")
    visit "/pets/#{@pet2.id}"
    click_button("Favorite this pet.")
  end

  scenario "see all favorited pets with name link and image" do
    visit '/favorites'
    picture = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"
    picture2 = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"

    within("#favorite#{@pet1.id}") do
       expect(page).to have_link("Name: #{@pet1.name}", href: "/pets/#{@pet1.id}")
       expect(page).to have_css("img[src*='#{picture}']")
       click_link("#{@pet1.name}")
       expect(current_path).to eq("/pets/#{@pet1.id}")
     end

     visit '/favorites'

     within("#favorite#{@pet2.id}") do
       expect(page).to have_link("Name: #{@pet2.name}", href: "/pets/#{@pet2.id}")
       expect(page).to have_css("img[src*='#{picture2}']")
       click_link("#{@pet2.name}")
       expect(current_path).to eq("/pets/#{@pet2.id}")
     end
  end

  scenario "see a message regarding no favorited pets if none have been favorited" do
    visit '/favorites'

    expect(page).to have_content("You have not favorited any pets.")
    expect(page).to_not have_content("Patra")

    visit "/pets/#{@pet1.id}"

    click_button("Favorite this pet.")

    visit '/favorites'

    expect(page).to_not have_content("You have not favorited any pets.")
    expect(page).to have_content("Patra")
  end

end
