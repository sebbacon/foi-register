# A term of the LGCS taxonomy, used for classifying the subject of requests

class LGCSTerm < ActiveRecord::Base
  belongs_to :broader_term, :class_name => 'LGCSTerm'
  has_many :requests
end
