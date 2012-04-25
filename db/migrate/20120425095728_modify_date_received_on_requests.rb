class ModifyDateReceivedOnRequests < ActiveRecord::Migration
  def up
    change_column_null(:requests, :date_received, true)
    change_column_default(:requests, :date_received, nil)
  end

  def down
    change_column_default(:requests, :date_received, Time.now)
    change_column_null(:requests, :date_received, false)
  end
end
