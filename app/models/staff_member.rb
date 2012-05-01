# A staff member, i.e. an employee of the public body who is
# authorised to interact with the application.

class StaffMember < ActiveRecord::Base
  has_secure_password
  
  attr_accessible :email, :password, :password_confirmation
  
  validates_presence_of :email
  validates_uniqueness_of :email
  
  def to_s
    email
  end
end
