class CreatePetApplications < ActiveRecord::Migration[5.1]
  def change
    create_table :pet_applications do |t|
      t.references :pet, foreign_key: true
      t.references :application, foreign_key: true
      t.boolean :adopted, default: false

      t.timestamps
    end
  end
end
