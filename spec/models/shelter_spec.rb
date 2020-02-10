require 'rails_helper'

RSpec.describe Shelter do
  describe 'relationships' do
    it { should have_many :pets}
  end

  describe 'relationships' do
    it { should have_many :reviews}
  end

  describe '#pets_pending?' do
    it 'returns true if any pets in a shelter are pending adoption' do
      @shelter1 = Shelter.create(name: "Bloke",
      address: "123456 E. Koko St.",
      city: "Aville",
      state: "CO",
      zip: "83504")

      pet1_path = "https://imgix.bustle.com/uploads/getty/2019/11/18/6296727a-d38c-40b4-8ffe-dbec5cd1b289-getty-954967324.jpg?w=1020&h=576&fit=crop&crop=faces&auto=format&q=70"

      @pet1 = Pet.create(image: pet1_path,
      name: "Patra",
      approximate_age: 2,
      sex: "free",
      shelter_id: @shelter1.id,
      shelter_name: @shelter1.name,
      description: "cuddly",
      adoption_status: "adoptable")

      expect(@shelter1.pets_pending?).to eq(false)
    end
  end
end
