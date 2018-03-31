require 'minitest/autorun'
require_relative 'location'

class LocationTest < Minitest::Test
  
  def setup
    @location = Location::new "Test", 1
    
    @avenue = Minitest::Mock.new "Dummy Road"
    @street = Minitest::Mock.new "Dummy Road"
    
    def @avenue.destination; 1; end
    def @avenue.name; "Dummy Ave."; end
    
    def @street.destination; 2; end
    def @avenue.name; "Dummy St."; end
    
    
    @location.avenue = @avenue
    @location.street = @street
  end
  
  # UNIT TESTS FOR METHOD move_to_random random
  # Equivalence classes:
  # random is 0 or 1, returns location ID of new location and name of new location
  # random is not 0 or 1, raises RuntimeError with message "Invalid random number"
  
  # If random is 0 or 1, then return location ID of new location and name of new location
  def test_valid_random
    location_id, name = @location.move_to_random 0
    
    assert location_id.is_a? Integer
    assert name.is_a? String
  end
  
  # If random is not 0 or 1, then raise RuntimeError with message "Invalid random number"
  # EDGE CASE
  def test_invalid_random
    assert_raises RuntimeError do 
      location_id, name = @location.move_to_random "Foobar"
    end
  end
end