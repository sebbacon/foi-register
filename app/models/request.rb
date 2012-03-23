class Request < ActiveRecord::Base
  belongs_to :requestor
  validates_presence_of :title
  
  @@statuses = [
    # tag, name, description
    ["new", "New", "A new request that has not even been acknowledged"],
    ["acknowledged", "Acknowledged", "A new request that has been acknowledged, but not had a substantive response or rejection"],
    
    ["done_rejected_vexatious", "Rejected as vexatious", "The request has been rejected as vexatious. In this case there is no legal obligation to respond to the requestor at all."],
    
    # The request is complete, and the requestor has been told:
    ["done_not_held", "Not held", "The information is not held"],
    ["done_supplied_all", "All information supplied", "All the requested information has been supplied"],
    ["done_supplied_some", "All information supplied", "Some of the requested information has been supplied"],
    
    # XXXX ["done_exempt_s15", ...]
  ]
  validates_presence_of :status
  validates_inclusion_of :status, :in => @@statuses.map{ |key, name, desc| key }
end
