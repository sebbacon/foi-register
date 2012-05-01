require "net/http"
require "rexml/document"

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
    State.delete_all
    for tag, title, description in statuses
      State.create(:tag => tag, :title => title, :description => description)
    end
  end
  
  task :lgcs_terms => :environment do
    def each_lgcs_item
      Rails.logger.info("Loading LGCS XML data...")
      lgcs_xml = Net::HTTP.get_response("www.esd.org.uk", "/standards/lgcs/2.01/lgcs.xml").body
      Rails.logger.info("Loaded")
      
      REXML::Document.new(lgcs_xml).elements.each("/ControlledList/Item") do |item|
        id = item.attributes["Id"].to_i
        name = item.elements["Name"].text
        notes = item.elements["ScopeNotes"].text
        broader_items = item.get_elements("BroaderItem")
        if broader_items.size > 0
          if broader_items.size > 1
            raise "Item %d (%s) has >1 BroaderItem" % [id, name]
          end
          broader_item_id = broader_items[0].attributes["Id"].to_i
          
          yield :id => id, :name => name, :notes => notes, :broader_term_id => broader_item_id
        else
          yield :id => id, :name => name, :notes => notes
        end
      end
    end
    
    LgcsTerm.delete_all
    each_lgcs_item do |item|
      Rails.logger.info "Creating LGCS term '#{item[:name]}' with id #{item[:id]}"
      term = LgcsTerm.new(item)
      term.id = item[:id]
      term.save!
    end
  end
  
  desc "Run all bootstrapping tasks"
  task :all => [:default_states, :lgcs_terms]
end
