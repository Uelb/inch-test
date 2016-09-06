class PastAttribute < ActiveRecord::Base

  belongs_to :tuple, polymorphic: true

end
