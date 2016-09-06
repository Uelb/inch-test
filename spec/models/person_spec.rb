require 'rails_helper'
require 'support/protected_update_spec_helper'

RSpec.describe Person, :type => :model do

  it_behaves_like "a protected_update", :email, :firstname

end