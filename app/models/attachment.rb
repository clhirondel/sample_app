class Attachment < ActiveRecord::Base
  
  include Rails.application.routes.url_helpers
  
  attr_accessible :description, :file
 
  belongs_to :attachable, :polymorphic => true

  validates :file, :uniqueness => {:scope => [:attachable_type, :attachable_id]}
  
  mount_uploader :file, FileUploader

end
