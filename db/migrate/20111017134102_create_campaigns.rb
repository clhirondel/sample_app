class CreateCampaigns < ActiveRecord::Migration
  def self.up
    create_table :campaigns do |t|
      t.string :name,   :limit => 32
      t.string :type,   :limit => 32
      t.string :description
      t.string :first_phone_number, :limit => 10
      t.string :last_phone_number, :limit => 10
      t.timestamps
      t.datetime  :deleted_at
    end
  end

  def self.down
    drop_table :campaigns
  end
end
