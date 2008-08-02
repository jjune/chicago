class Device < ActiveRecord::Base
	belongs_to :player
	has_many :query_transactions
end
