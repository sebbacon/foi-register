# == Schema Information
#
# Table name: requests
#
#  id            :integer         not null, primary key
#  title         :string(255)
#  status        :string(255)
#  requestor_id  :integer
#  created_at    :datetime        not null
#  updated_at    :datetime        not null
#  body          :text
#  date_received :date
#  due_date      :date            not null
#

class Request < ActiveRecord::Base
  belongs_to :requestor
  validates_presence_of :title
  has_many :request_states
  has_many :states, :through => :request_states, :order => :created_at
  accepts_nested_attributes_for :requestor

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

  def days_until_due
    if !self.due_date.nil?
      (self.due_date - Date.today).to_i
    end
  end
  
  def date_received_or_created
    date_received || created_at.to_date
  end
  
  class << self
    # Get overdue requests, the most overdue first
    def overdue
      self.where("due_date <= date('now')").order("due_date ASC")
    end
  end
  
end
