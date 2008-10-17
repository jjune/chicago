class Sponsor < User
	has_many :prizes
	
	#Validates against contact information only for sponsor registration
  validates_presence_of      :first_name, :last_name, :address1, :city, :state, :zipcode, :country, :phone_number
end
