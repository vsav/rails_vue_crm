class AddApiTokenToStaffs < ActiveRecord::Migration[6.0]
  def up
    add_column :staffs, :api_token, :string, default: -> { 'gen_random_uuid()' }
    add_index :staffs, :api_token, unique: true
  end

  def down
    remove_column :staffs, :api_token
    remove_index :staffs, :api_token
  end
end
