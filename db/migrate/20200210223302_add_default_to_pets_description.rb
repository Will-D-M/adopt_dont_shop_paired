class AddDefaultToPetsDescription < ActiveRecord::Migration[5.1]
  def change
    change_column :pets, :description, :string, :default => "Looking for a home"
    Pet.all.where(description: nil).update_all(description: "Looking for a home")
  end
end
