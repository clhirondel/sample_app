class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.string :name
      t.string :description
      t.string :type
      t.string :first_office_declined_phone
      t.string :last_office_declined_phone
      t.timestamps
      t.datetime :deleted_at
    end
   add_index :microposts, :user_id
  end

  def self.down
    drop_table :campaigns
  end
end
