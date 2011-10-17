class Client < ActiveRecord::Base
  attr_accessible :string1,:integer1, :attachments_attributes
  
  belongs_to :prospect
  
  validates :string1, :length   => { :maximum => 32 },
                :allow_nil => true, :allow_blank => true  
  validates :integer1, :numericality  => { :less_than_or_equal_to => 100 },
                :allow_nil => true, :allow_blank => true
  
  validates :prospect_id, :presence => true

  has_many :attachments, :as => :attachable
  
  accepts_nested_attributes_for :attachments, 
    :allow_destroy => true, :reject_if => lambda { |a| a[:file].nil? && a[:file].blank? }
    
  default_scope :order => 'clients.updated_at DESC'
  
end
