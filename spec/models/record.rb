require 'rails_helper'

RSpec.describe Record, :type => :model do

	describe 'validation' do
	  it { should validate_presence_of(:url) }
	  it { should validate_uniqueness_of(:url) }
	end

end


