class CreateClients < ActiveRecord::Migration
  def self.up
    create_table :clients do |t|
      t.integer :prospect_id
      t.string :string1
      t.integer :integer1

      t.timestamps
      t.datetime  :deleted_at
    end
  end

  def self.down
    drop_table :clients
  end
end
