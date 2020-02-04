require 'rails_helper'

RSpec.describe Shelter do
  describe 'relationships' do
    it { should have_many :pets}
  end

  describe 'relationships' do
    it { should have_many :reviews}
  end
end
