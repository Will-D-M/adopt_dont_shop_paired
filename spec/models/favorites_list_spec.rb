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

  end
end
