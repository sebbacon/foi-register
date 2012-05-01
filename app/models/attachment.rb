# == Schema Information
#
# Table name: attachments
#
#  id                       :integer         not null, primary key
#  created_at               :datetime        not null
#  updated_at               :datetime        not null
#  file                     :string(255)     not null
#  content_type             :text            not null
#  size                     :integer         not null
#  request_or_response_id   :integer
#  request_or_response_type :string(255)
#

class Attachment < ActiveRecord::Base
  mount_uploader :file, AttachmentUploader
  belongs_to :request_or_response, :polymorphic => true
  before_save :update_metadata
  
  private
  def update_metadata
    if file.present? && file_changed?
      self.content_type = file.file.content_type
      self.size = file.file.size
      self.filename = file.file.filename
    end
  end
end
