require 'rails_helper'

RSpec.describe FavoritesList do
  subject { FavoritesList.new({'1' => 2, '2' => 3}) }

  describe "#total_count" do
    it "can calculate the total number of favorites it holds" do
        expect(subject.total_count).to eq(5)
    end
  end

  describe "#add_pet" do
    it "adds a pet to its pets_favorite" do
      favorites = FavoritesList.new({
        '1' => 2,
        '2' => 3
        })

        subject.add_pet(1)
        subject.add_pet(2)

        expect(subject.pets_favorite).to eq({'1' => 3, '2' => 4})
    end

    it "adds a pet that hasn't been added yet" do
      subject.add_pet('3')

      expect(subject.pets_favorite).to eq({'1' => 2, '2' => 3, '3' => 1})
    end

    describe "#count_of" do
      it "returns the count of all pets in the favorites" do
        favorites = FavoritesList.new({})

        expect(favorites.count_of(5)).to eq(0)
      end
    end

    describe "#favorited?" do
      it "can check if a pet is on the favorites list" do
        favorites = FavoritesList.new({})
        shelter1 = Shelter.create(name: "Bloke",
        address: "123456 E. Koko St.",
        city: "Aville",
        state: "CO",
        zip: "83504")

        pet1_path = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"

        pet1 = Pet.create(image: pet1_path,
        name: "Patra",
        approximate_age: 2,
        sex: "female",
        shelter_id: shelter1.id,
        shelter_name: shelter1.name)

        expect(favorites.has_pet?(pet1.id)).to eq(false)

        favorites.add_pet(pet1.id)

        expect(favorites.has_pet?(pet1.id)).to eq(true)
      end
    end

  end
end
