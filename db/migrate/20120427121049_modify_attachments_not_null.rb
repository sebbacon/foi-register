class ModifyAttachmentsNotNull < ActiveRecord::Migration
  def up
    Attachment.delete_all("response_id is null or content_type is null or file is null or size is null")
    change_column_null(:attachments, :response_id, false)
    change_column_null(:attachments, :content_type, false)
    change_column_null(:attachments, :file, false)
    change_column_null(:attachments, :size, false)
  end

  def down
    change_column_null(:attachments, :response_id, true)
    change_column_null(:attachments, :content_type, true)
    change_column_null(:attachments, :file, true)
    change_column_null(:attachments, :size, true)
  end
end
