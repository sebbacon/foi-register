class AddMetadataToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :content_type, :text
    add_column :attachments, :size, :integer
  end
end
