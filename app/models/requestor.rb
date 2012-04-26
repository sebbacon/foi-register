class Requestor < ActiveRecord::Base
  has_many :requests
  
  def to_s
    "%s <%s>" % [name, email]
  end
end
