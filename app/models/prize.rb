class Prize < ActiveRecord::Base
	has_many :query_transactions
end
