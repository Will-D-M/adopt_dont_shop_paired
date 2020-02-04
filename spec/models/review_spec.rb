require 'rails_helper'

RSpec.describe Review, type: :model do
  describe 'relationships' do
    it {should belong_to :shelter}
  end

  describe "validations" do
    it { should validate_presence_of :title
      should validate_presence_of :rating
      should validate_presence_of :content
      should validate_presence_of :shelter}
  end
end
