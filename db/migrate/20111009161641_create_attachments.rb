class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.string :file
      t.text :description
      t.references :attachable, :polymorphic => true

      t.timestamps
      t.datetime :deleted_at
    end
  end

  def self.down
    drop_table :attachments
  end
end
