class AddResponseRelationToAttachment < ActiveRecord::Migration
  def change
      add_column :attachments, :response_id, :integer
      add_index :attachments, :response_id
  end
end
