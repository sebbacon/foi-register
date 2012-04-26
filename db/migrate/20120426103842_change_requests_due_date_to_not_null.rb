class ChangeRequestsDueDateToNotNull < ActiveRecord::Migration
  def up
    Request.where("due_date is null").find_each do |request|
      date_received = request.date_received || request.created_at.to_date
      request.due_date = date_received + 28.days
      request.save!
    end
    change_column_null(:requests, :due_date, false)
  end

  def down
    change_column_null(:requests, :due_date, true)
  end
end
