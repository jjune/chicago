class QueryTransaction < ActiveRecord::Base
	belongs_to :device
	belongs_to :player
	belongs_to :prize
end
