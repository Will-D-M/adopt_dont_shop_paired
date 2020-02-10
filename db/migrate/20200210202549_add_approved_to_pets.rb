class AddApprovedToPets < ActiveRecord::Migration[5.1]
  def change
    add_column :pets, :approved, :boolean, :default => false
  end
end
