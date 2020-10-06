class CreateClientOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :client_organizations do |t|
      t.references :client
      t.references :organization

      t.timestamps
    end
  end
end
