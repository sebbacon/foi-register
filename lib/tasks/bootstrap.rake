namespace :bootstrap do
  
  desc "Add the default states"
  task :default_states => :environment do
    statuses = [
                # tag, name, description
                ["new", "New", "A new request that has not even been acknowledged"],
                ["acknowledged", "Acknowledged", "A new request that has been acknowledged, but not had a substantive response or rejection"],
                
                ["done_rejected_vexatious", "Rejected as vexatious", "The request has been rejected as vexatious. In this case there is no legal obligation to respond to the requestor at all."],
                
                # The request is complete, and the requestor has been told:
                ["done_not_held", "Not held", "The information is not held"],
                ["done_supplied_all", "All information supplied", "All the requested information has been supplied"],
                ["done_supplied_some", "Some information supplied", "Some of the requested information has been supplied"],
                
                # XXXX ["done_exempt_s15", ...]
               ]
    for tag, title, description in statuses
      State.create(:tag => tag, :title => title, :description => description)
    end
  end
  
  desc "Run all bootstrapping tasks"
  task :all => [:default_states]
end
