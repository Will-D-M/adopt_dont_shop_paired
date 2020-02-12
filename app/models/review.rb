class Review < ApplicationRecord
  belongs_to :shelter

  validates_presence_of :title
  validates_presence_of :rating
  validates_presence_of :content
  validates_presence_of :shelter

  before_save :default_values

  def default_values
    self.picture = "https://images-ra.adoptapet.com/images/Homepage-DogV2.png" if self.picture.nil? || self.picture == ""
  end
end
