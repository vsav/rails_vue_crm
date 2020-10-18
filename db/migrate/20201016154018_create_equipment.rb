class CreateEquipment < ActiveRecord::Migration[6.0]
  def change
    create_table :equipment do |t|
      t.string :name, null: false
      t.string :kind, null: false
      t.string :serial, null: false
      t.references :organization

      t.timestamps
    end
  end
end
