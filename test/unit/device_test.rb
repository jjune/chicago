require File.dirname(__FILE__) + '/../test_helper'

class DeviceTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  def test_truth
    assert true
  end
  
  def setup
  	@existing_request = ActionController::TestRequest.new
  	@existing_request.parameters[:device_uniqueid] = "khlju"
  	@existing_request.parameters[:device_type] = "where"
  	
  	@new_request = ActionController::TestRequest.new
  	@new_request.parameters[:device_uniqueid] = "AAAA"
  	@new_request.parameters[:device_type] = "where"
  end
  
  def test_find_existing_device
  
  	device = Device.find_or_create_device(@request)
  	
  	assert_equal 2, device.id
  end
  
  def test_find_existing_device
  	device = Device.find_or_create_device(@existing_request)
  	assert_equal 2, device.id
  end
  
  def test_new_device_request
  	device = Device.find_or_create_device(@new_request)
  	assert_equal 3, device.id
  end
  
  def test_where_extension
  	device = Device.find_or_create_device(@new_request)
  	assert_equal "-84.49008", device.lng
  	assert_equal "33.84275", device.lat
  	assert_equal "Emulator", device.carrier
  	assert_equal "240", device.screenwidth
  	assert_equal "medium", device.textsize 
  end
  
  def test_unqiue_short_code_generated
  	
  	assert true
  	#device = Device.find_or_create_device
  	
  end
  	
end
