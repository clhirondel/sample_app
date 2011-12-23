class Role < ActiveRecord::Base
  attr_accessible :position
  
  has_and_belongs_to_many :users
end
