class AddPhoneAndFullnameToClients < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :phone, :string, null: false
    add_column :clients, :full_name, :string, null: false
  end
end
