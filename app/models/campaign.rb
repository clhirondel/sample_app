#Encoding: UTF-8
class Campaign < ActiveRecord::Base

  attr_accessible :name, :campaign_type, :description, :first_phone_number, :last_phone_number
  
  belongs_to :user
  
  has_many :prospects
  
  validates :name, :length   => { :maximum => 32 },
              :presence => true, :uniqueness => true
            
  validates :campaign_type, :presence => true
  
  validates :first_phone_number, :length => { :is => 10 }, :presence => true, :if => :campaign_is_company?,
                 :allow_nil => true, :allow_blank => true
  
  validates :last_phone_number, :length => { :is => 10 }, :if => :campaign_is_company?,
                :allow_nil => true, :allow_blank => true

  def feed_on_connected_user
     Campaign.where("user_id = ?", id)
  end
 
  def self.selected_type(campaign_type)
    if campaign_type
      where('campaign_type = ?', "#{campaign_type}")
    else
      scoped
    end
  end
  
  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
 
  private
  
  def campaign_is_company?
    self.campaign_type == "Décline"
  end
  
end
