class Request < ActiveRecord::Base
  belongs_to :requestor
  validates_presence_of :title
  has_many :request_states
  has_many :states, :through => :request_states, :order => :created_at
  #validates_presence_of :state

  def state
    self.states.last || State.new
  end

  def state=(state)
    self.states << state
  end
 
  def state_attributes=(attributes)
    # process an attributes hash passed from nested form field
    self.state = State.find(attributes[:id])
  end

end
