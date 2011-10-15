class CreateProspects < ActiveRecord::Migration
  def self.up
    create_table  :prospects do |t|
      t.string    :last_name,   :limit => 32
      t.string    :first_name,  :limit => 32
      t.string    :civility,    :limit => 3
      t.integer   :birthyear,    :limit => 4
      t.string    :email,  :limit => 64
      t.string    :address
      t.string    :postal_code, :limit => 5
      t.string    :digital_code,  :limit => 10
      t.integer   :floor, :limit => 3
      t.string    :city,  :limit => 64
      t.string    :phone_number, :limit => 10
      t.string    :office_phone_number, :limit => 10
      t.string    :mobile_phone_number, :limit => 10
      t.string    :situation_familiale,  :limit => 32
      t.integer   :nb_enfants,  :limit => 2
      t.integer   :nb_enfants_a_charges,  :limit => 2
      t.string    :professional_status,   :limit => 32
      t.integer   :revenus_mensuels_net,  :limit => 8
      t.string    :logement_rp,   :limit => 32
      t.integer   :mensualite_rp,    :limit => 8
      t.integer   :impots_sur_le_revenu,  :limit => 8
      t.integer   :charges_rp,  :limit => 8
      t.integer   :charges_autres,  :limit => 8
      t.integer   :taux_endettement,  :limit => 2
      t.string    :prospect_status,  :limit => 32
      t.datetime  :meeting_at
      t.string    :meeting_place,  :limit => 128
      t.string    :to_recall, :limit => 10
      t.datetime  :to_recall_at
      t.string    :off_target_cause, :limit => 32
      t.string    :comments
      t.time      :timespent
      t.integer   :campaign_id
      t.integer   :user_id
      t.integer   :consultant_id
 
      t.timestamps
      t.datetime  :deleted_at
    end
    add_index :prospects, :user_id
    add_index :prospects, :campaign_id
  end

  def self.down
    drop_table :prospects
  end
end
