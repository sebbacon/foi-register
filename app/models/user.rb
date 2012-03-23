# A user, i.e. an employee of the public body who is
# authorised to interact with the application.

class User < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :password, :password_confirmation
  
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end
end
