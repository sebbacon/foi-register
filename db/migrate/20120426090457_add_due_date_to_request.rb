class AddDueDateToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :due_date, :date
    add_index :requests, :due_date

  end
end
