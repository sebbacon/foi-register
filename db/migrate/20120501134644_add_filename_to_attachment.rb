class AddFilenameToAttachment < ActiveRecord::Migration
  def change
    add_column :attachments, :filename, :string
    Attachment.all.each do |attachment|
      attachment.filename = attachment.file.file.filename
      attachment.save!
    end
  end
end
