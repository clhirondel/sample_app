class Campaign < ActiveRecord::Base

  attr_accessible :name, :type, :description, :first_phone_number, :last_phone_number
  
  has_many :prospects
  
  validates :name, :length   => { :maximum => 32 },
              :presence => true
            
  validates :type, :presence => true
  
  validates :first_phone_number, :length => { :is => 10 }, :presence => true,
                :if => :is_company?, :uniqueness => true
  
  validates :last_phone_number, :length => { :is => 10 }, :allow_nil => true,
                :allow_blank => true, :uniqueness => true

  def self.search(search)
    if search
      where('name LIKE ?', "%#{search}%")
    else
      scoped
    end
  end
 
  def self.selected_type(type)
    if type
      where('type = ?', "#{type.humanize}")
    else
      scoped
    end
  end
  
  private
  
  def is_company?
    self.type == "Entreprise"
  end

end
