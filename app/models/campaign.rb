class Campaign < ActiveRecord::Base
  
  attr_accessible :name, :description, :type, :first_office_declined_phone, :last_office_declined
   
  has_many :prospects
  
  validates :name, :uniqueness => true
  
  validates :description, :uniqueness => true
  
  validates :first_office_declined_phone, :length => { :minimum => 4, :maximum => 9 }, :numericality  => true,
     presence=>{:if => :declined_type_choosed?}, :uniqueness => true
  
  validates :last_office_declined_phone, :length => { :minimum => 4, :maximum => 9 }, :numericality  => true,
     presence=>{:if => :declined_type_choosed?}, :uniqueness => true
  
  
  
  def declined_type_choosed?
    type == "Déclinaison"
  end 
end
