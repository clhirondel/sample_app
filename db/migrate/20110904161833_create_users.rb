class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :lastname
      t.string :firstname
      t.string :email

      t.timestamps
      t.datetime  :deleted_at
    end
  end

  def self.down
    drop_table :users
  end
end
