class ModifyResponsesRequestNotNull < ActiveRecord::Migration
  def up
    Response.delete_all("request_id is null")
    change_column_null(:responses, :request_id, false)
  end

  def down
    change_column_null(:responses, :request_id, true)
  end
end
