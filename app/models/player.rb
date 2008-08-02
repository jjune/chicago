class Player < User
	has_many :query_transactions
	has_many :devices
end
