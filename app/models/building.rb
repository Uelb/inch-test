class Building < ActiveRecord::Base

  include ProtectedUpdate
  protect_attributes(:manager_name)

end
