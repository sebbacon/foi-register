# == Schema Information
#
# Table name: responses
#
#  id           :integer         not null, primary key
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#  private_part :text            not null
#  public_part  :text            not null
#  request_id   :integer         not null
#

class Response < ActiveRecord::Base
  belongs_to :request
  has_many :attachments
  accepts_nested_attributes_for :attachments
  accepts_nested_attributes_for :request

  def request_attributes=(attributes)
    # process an attributes hash passed from nested form field
    request = Request.find(attributes[:id])
    request.state = State.find(attributes[:state_attributes][:id])
  end

end
