class AddFlagsToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :is_published, :boolean, :null => false, :default => false
    add_column :requests, :is_requestor_name_visible, :boolean, :null => false, :default => false
  end
end
