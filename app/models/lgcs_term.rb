# == Schema Information
#
# Table name: lgcs_terms
#
#  id              :integer         not null, primary key
#  name            :string(255)     not null
#  broader_term_id :integer
#  notes           :text
#

# A term of the LGCS taxonomy, used for classifying the subject of requests

class LGCSTerm < ActiveRecord::Base
  belongs_to :broader_term, :class_name => 'LGCSTerm'
  has_many :requests
end
