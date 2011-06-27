require 'digest/sha2'

class User < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => true
  
  validates :password, :confirmation => true #one password field, and one for the re-type password confirmation
  attr_accessor :password_confirmation
  attr_reader :password
  
  validate :password_must_be_present

  def User.authenticate(name, password)
    if user = find_by_name(name)
      if user.hashed_password == encrypt_password(password, user.salt)
        user
      end
    end
  end
  
  def User.encrypt_password(password, salt)
    Digest::SHA2.hexdigest(password + "manamam" + salt) #string = first letter of each of our first names =P
  end  

  #'password' is a virtual atribute
  #creates a salt and sets the hashed password
  def password=(password)
    @password = password
    
    if password.present?
      generate_salt
      self.hashed_password = self.class.encrypt_password(salt)
    end
  end

  private    
  
    def password_must_be_present
        errors.add(:password, "Missing password") unless hashed_password.present?
    end
    
    def generate_salt 
        self.salt = self.object_id.to_s + rand.to_s #doing self.salt tells ruby that  its not a local variable
    end
end
