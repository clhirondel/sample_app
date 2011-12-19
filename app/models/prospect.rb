class Prospect < ActiveRecord::Base
  attr_accessible :last_name, :first_name, :civility, :birthyear,  :email, :address, :postal_code, :digital_code,
        :floor, :city, :phone_number, :office_phone_number, :mobile_phone_number, :situation_familiale, :nb_enfants_a_charges,  
        :professional_status, :revenus_mensuels_net, :logement_rp, :mensualite_rp, :impots_sur_le_revenu, :charges_rp, :charges_autres,
        :taux_endettement, :prospect_status, :meeting_at, :meeting_place, :to_recall, :to_recall_at, :hors_cible_cause, :comments, :consultant_id, :timespent
  
  belongs_to :user
  
  belongs_to :campaign

  has_one :client, :dependent => :destroy

  #phonenumber_regex = /\A([0][0-9]([-. ]?[0-9]{2}){4,})?\z/i
  
  #datetime_regex = /(0?[1-9]|[12][0-9]|3[01])/(0?[1-9]|1[012])/((19|20)\\d\\d)/i

  
  validates :last_name, :uniqueness => { :scope => [:first_name, :phone_number] | [:first_name, :office_phone_number] | [:first_name, :mobile_phone_number] },
                :length   => { :maximum => 32 }

  validates :first_name, :length   => { :maximum => 32 },
                :allow_nil => true, :allow_blank => true
                  
  validates :civility, :length => { :maximum => 3 }
  
  validates :birthyear, :numericality => { :less_than_or_equal_to => 120, :greater_than_or_equal_to => 18 },
                :allow_nil => true, :allow_blank => true
  
  validates :email, :email_format => true,
                :allow_nil => true, :allow_blank => true
  
  validates :postal_code, :numericality  => true, :length   => { :minimum => 4, :maximum => 5 },
                  :allow_nil => true, :allow_blank => true
                  
  validates :digital_code, :length   => { :minimum => 2, :maximum => 10 },
                :allow_nil => true, :allow_blank => true
                
  validates :floor, :numericality  => true,
                :allow_nil => true, :allow_blank => true
  
  validates :city,  :length   => { :maximum => 64 },
                :allow_nil => true, :allow_blank => true

  validates :phone_number, :uniqueness => { :scope => [:last_name, :first_name] }, :numericality  => true,
                :length => { :is => 10 }, :allow_nil => true, :allow_blank => true
                 #, :scope => :user_id pour avoir phone_number_1 & usier_id uniques
   
  validates :office_phone_number, :numericality  => true, :uniqueness => { :scope => [:last_name, :first_name] },
                :length => { :is => 10 }, :allow_nil => true, :allow_blank => true
                 #, :scope => :user_id pour avoir phone_number_1 & usier_id uniques

  validates :mobile_phone_number, :uniqueness => { :scope => [:last_name, :first_name] },
                :length => { :is => 10 }, :allow_nil => true, :allow_blank => true
  
  validates :nb_enfants, :numericality  => true,  :length   => { :maximum => 30 },
                :allow_nil => true, :allow_blank => true
  
  validates :nb_enfants_a_charges, :numericality  => true,  :length   => { :maximum => 30 },
                :allow_nil => true, :allow_blank => true
  
  validates :revenus_mensuels_net, :numericality  => true,  :length   => { :maximum => 30 },
                :allow_nil => true, :allow_blank => true
  
  validates :mensualite_rp, :numericality => true, :length => { :maximum => 8 },
                :allow_nil => true, :allow_blank => true
  
  validates :charges_rp, :numericality => true, :length => { :maximum => 8 },
                :allow_nil => true, :allow_blank => true
  
  validates :charges_autres, :numericality => true, :length => { :maximum => 8 },
                :allow_nil => true, :allow_blank => true
  
  validates :taux_endettement, :numericality => { :less_than_or_equal_to => 100 },
                :allow_nil => true, :allow_blank => true

  validates :prospect_status, :length => { :maximum => 32 }, :presence => true
  
  validates :meeting_at, :date => {:after => Time.now, :before => Time.now + 1.year},
                :allow_nil => true, :allow_blank => true
  
  validates :meeting_place, :length => { :maximum => 32 }
  
  validates :to_recall, :length => { :is => 10 }, :presence => true, :if => :to_recall_status_selected?
  
  validates :to_recall_at, :date  => { :after => Time.now, :before => Time.now + 1.year },
                :presence => true, :if => :to_recall_status_selected?
  
  validates :off_target_cause, :length => { :maximum => 32 }, :presence => true, :if => :off_target_selected?
  
  validates :user_id, :presence => true
  
  before_save :age_to_birthyear
  
  #searchable do
  #  text :last_name
  #  text :city, :boost => 5
  #  text :first_name
  #  text :postal_code
  #  text :prospect_status
  #  string :prospect_status
  #  string :last_name
  #  time :updated_at
  #Send
  
  def feed_on_connected_user
     Prospect.where("user_id = ?", id)
  end
 
  def self.search(search)
    if search
      where('last_name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
 
  def self.selected_status(prospect_status)
    if prospect_status
      where('prospect_status = ?', "#{prospect_status.humanize}")
    else
      scoped
    end
  end
  
  def age_to_birthyear
    if !self.birthyear.nil?
      self.birthyear = Time.now.year - self.birthyear
    end
  end
  
  private
  
  def to_recall_status_selected?
    self.prospect_status == "To recall" && self.meeting_at_changed?
  end
  
  def off_target_selected?
    self.prospect_status == "Off target"
  end
end