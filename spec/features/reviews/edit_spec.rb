require 'rails_helper'

describe "As a visitor on the review edit page" do
  before(:each) do
    @shelter1 = Shelter.create(name: "Mike's Shelter", address: "1331 17th Street", city: "Denver", state: "CO", zip: "80202")

    @review1 = Review.create( title: "Good",
                              rating: 5,
                              content: "I found my new best friend",
                              picture: "https://images-ra.adoptapet.com/images/Homepage-DogV2.png",
                              shelter_id: "#{@shelter1.id}" )

    visit "/shelters/#{@review1.id}/reviews/edit"
  end

  describe "I see an edit shelter review form with pre-populated data" do
    it "and can fill in prepopulated data with edits" do
      expect(page).to have_selector("input[value=#{@review1.title}]")
      expect(page).to have_selector("input[value=#{@review1.rating}]")
      expect(page).to have_xpath("//input[@value='#{@review1.content}']")
      expect(find_field('Picture').value).to eq(@review1.picture)

      title = "Horrible"
      rating = 1
      content = "I kicked that dog out."
      picture = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"

      fill_in 'Title', with: title
      fill_in 'Rating', with: rating
      fill_in 'Content', with: content
      fill_in 'Picture', with: picture

      click_button 'Submit'

      expect(current_path).to eq("/shelters/#{@shelter1.id}")
      expect(page).to have_content(title)
      expect(page).to have_content(rating)
      expect(page).to have_content(content)
      expect(page).to have_css("img[src*='#{picture}']")
      expect(page).to_not have_content("Good")
      expect(page).to_not have_content("I found my new best friend")
    end
  end

  it 'I see an error message if I submit without required fields' do
    rating = 1
    content = "I kicked that dog out."
    picture = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png"

    fill_in 'Title', with: ""
    fill_in 'Rating', with: rating
    fill_in 'Content', with: content
    fill_in 'Picture', with: picture

    click_button 'Submit'

    expect(current_path).to eq("/shelters/#{@review1.id}/reviews/edit")
    expect(page).to have_content("Please fill out all required fields.")

    fill_in 'Title', with: title
    fill_in 'Rating', with: ""
    fill_in 'Content', with: content
    fill_in 'Picture', with: picture

    click_button 'Submit'

    expect(current_path).to eq("/shelters/#{@review1.id}/reviews/edit")
    expect(page).to have_content("Please fill out all required fields.")

    fill_in 'Title', with: title
    fill_in 'Rating', with: rating
    fill_in 'Content', with: ""
    fill_in 'Picture', with: picture

    click_button 'Submit'

    expect(current_path).to eq("/shelters/#{@review1.id}/reviews/edit")
    expect(page).to have_content("Please fill out all required fields.")

    fill_in 'Title', with: title
    fill_in 'Rating', with: rating
    fill_in 'Content', with: content

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
