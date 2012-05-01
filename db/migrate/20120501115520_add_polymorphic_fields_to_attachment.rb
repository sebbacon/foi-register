class AddPolymorphicFieldsToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :request_or_response_id, :integer
    add_column :attachments, :request_or_response_type, :string
    remove_column :attachments, :response_id
  end
end
