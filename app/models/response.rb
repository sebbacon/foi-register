# == Schema Information
#
# Table name: responses
#
#  id           :integer         not null, primary key
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  private_part :text            not null
#  public_part  :text            not null
#  request_id   :integer
#

class Response < ActiveRecord::Base
  belongs_to :request
end
