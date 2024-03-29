class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name
      t.string :position
      t.string :description
      t.timestamps
      t.datetime :deleted_at
    end
  end

  def self.down
    drop_table :roles
  end
end
