class Shelter < ApplicationRecord
  has_many :pets, dependent: :destroy
end
