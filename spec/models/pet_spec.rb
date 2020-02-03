require 'rails_helper'

RSpec.describe Pet do
  describe 'relationships' do
    it {should belong_to :shelter}
  end
end
