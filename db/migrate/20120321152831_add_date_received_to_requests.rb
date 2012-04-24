class AddDateReceivedToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :date_received, :date, :null => false, :default => Time.now
  end
end
