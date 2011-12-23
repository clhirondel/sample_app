class User < ActiveRecord::Base

  
  has_and_belongs_to_many :roles
  
  
  attr_accessor :password
  
  attr_accessible :lastname, :firstname, :email, :password, :password_confirmation, :role_ids

  has_many :campaigns
  
  has_many :prospects
  
  has_many :microposts, :dependent => :destroy
  
  has_many :relationships, :foreign_key => "follower_id",
                           :dependent => :destroy
                         
  has_many :following, :through => :relationships, :source => :followed
  
  validates :lastname,  :presence => true, :uniqueness => { :scope => [:firstname]},
                        :length   => { :maximum => 50 }
                      
  validates :firstname, :presence => true, :uniqueness => { :scope => [:lastname]},
                        :length  => { :maximum => 50 }
                      
  validates :email, :presence => true,
                    :email_format => true,
                    :uniqueness => { :case_sensitive => false }
                  
   # Crée automatique l'attribut virtuel 'password_confirmation'.
  validates :password, :presence     => true,
                       :confirmation => true,
                       :length       => { :within => 6..40 }

  before_save :encrypt_password
  
  #  Retour true (vrai) si le mot de passe correspond.
  def has_password?(submitted_password )
    # Compare encrypted_password avec la version cryptée de
    # password_soumis.
    encrypted_password == encrypt(submitted_password )
  end
  
  def self.authenticate(email, submitted_password)
    user = find_by_email(email)
    return nil  if user.nil?
    return user if user.has_password?(submitted_password)
  end
  
  def self.authenticate_with_salt(id, cookie_salt)
    user = find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
  
  def role?(role)
    return !!self.roles.find_by_name(role.to_s.camelize)
  end
  
  def feed
    # C'est un préliminaire. Cf. chapitre 12 pour l'implémentation complète.
    Micropost.where("user_id = ?", id)
  end
  
  private
  
    def encrypt_password
      self.salt = make_salt if new_record?
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end
    
    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end
  
end
