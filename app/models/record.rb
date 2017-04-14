class Record < ApplicationRecord
	validates :url, :presence => true, :uniqueness => true
end
