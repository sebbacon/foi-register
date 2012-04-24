class RequestState < ActiveRecord::Base
  belongs_to :request
  belongs_to :state
end
