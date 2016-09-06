class Person < ActiveRecord::Base

  include ProtectedUpdate
  protect_attributes(:home_phone_number, :mobile_phone_number, :email, :address)

end
