class AddApiTokenToClients < ActiveRecord::Migration[6.0]
  def up
    add_column :clients, :api_token, :string, default: -> { 'gen_random_uuid()' }
    add_index :clients, :api_token, unique: true
  end

  def down
    remove_column :clients, :api_token
    remove_index :clients, :api_token
  end
end
