# == Schema Information
#
# Table name: requestors
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  notes      :text
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Requestor < ActiveRecord::Base
  has_many :requests
end
