class PrizeItem < ActiveRecord::Base
	belongs_to :prize
	belongs_to :device
end
