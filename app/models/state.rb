class State < ActiveRecord::Base
  has_many :request_states
  has_many :requests, :through => :request_states
end
