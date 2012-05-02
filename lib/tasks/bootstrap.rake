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
                
                # Exemptions guidance is at http://www.justice.gov.uk/information-access-rights/foi-guidance-for-practitioners/exemptions-guidance
                ["done_exempt_s21", "Exempt under Section 21", "Exempt: Information Accessible By Other Means"],
                ["done_exempt_s22", "Exempt under Section 22", "Exempt: Information Intended For Future Publication"],
                ["done_exempt_s23", "Exempt under Section 23", "Exempt: Information Supplied by, or Related to, Bodies Dealing with Security Matters"],
                ["done_exempt_s24", "Exempt under Section 24", "Exempt: National Security"],
                ["done_exempt_s26", "Exempt under Section 26", "Exempt: Defence"],
                ["done_exempt_s27", "Exempt under Section 27", "Exempt: International Relations"],
                ["done_exempt_s28", "Exempt under Section 28", "Exempt: Relations Within The United Kingdom"],
                ["done_exempt_s29", "Exempt under Section 29", "Exempt: The Economy"],
                ["done_exempt_s30", "Exempt under Section 30", "Exempt: Investigations And Proceedings Conducted By Public Authorities"],
                ["done_exempt_s31", "Exempt under Section 31", "Exempt: Law Enforcement"],
                ["done_exempt_s32", "Exempt under Section 32", "Exempt: Court Records"],
                ["done_exempt_s33", "Exempt under Section 33", "Exempt: Audit Functions"],
                ["done_exempt_s34", "Exempt under Section 34", "Exempt: Parliamentary Privilege"],
                ["done_exempt_s35", "Exempt under Section 35", "Exempt: Formulation Of Government Policy"],
                ["done_exempt_s36", "Exempt under Section 36", "Exempt: Prejudice to Effective Conduct of Public Affairs"],
                ["done_exempt_s37", "Exempt under Section 37", "Exempt: Communications With Her Majesty, With Other Members Of The Royal Household, And The Conferring By The Crown Of Any Honour Or Dignity"],
                ["done_exempt_s38", "Exempt under Section 38", "Exempt: Health And Safety"],
                ["done_exempt_s39", "Exempt under Section 39", "Exempt: Environmental Information"],
                ["done_exempt_s40", "Exempt under Section 40", "Exempt: Personal Information"],
                ["done_exempt_s41", "Exempt under Section 41", "Exempt: Information Provided In Confidence"],
                ["done_exempt_s42", "Exempt under Section 42", "Exempt: Legal Professional Privilege"],
                ["done_exempt_s43", "Exempt under Section 43", "Exempt: Commercial Interests"],
                ["done_exempt_s44", "Exempt under Section 44", "Exempt: Prohibitions On Disclosure"],
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
