# == Schema Information
#
# Table name: attachments
#
#  id         :integer         not null, primary key
#  created_at :datetime        not null
#  updated_at :datetime        not null
#  file       :string(255)
#

class Attachment < ActiveRecord::Base
  mount_uploader :file, FileUploader
end
