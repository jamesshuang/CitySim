require 'minitest/autorun'
require_relative 'driver'

class DriverTest < Minitest::Test
  
  def setup
    @map = Minitest::Mock.new "Map"
    
    def @map.check_for_classes classes, current_location; 1; end
    def @map.check_for_books books, current_location; 1; end
    def @map.check_for_toys toys, current_location; 1; end
    
    current_location = 1
    @driver_id = 1
    
    def @map.next_location location
      return 3, "Bar St."
    end
    
    def @map.location_name location; "Dummy Location"; end
    
    @driver = Driver::new current_location, @map, @driver_id
  end
  
  # UNIT TESTS FOR METHOD move
  # Equivalence classes:
  # Location of driver is updated to the next random location, 
  # and driver's movement is printed out
  
  # This tests that the location of the driver is updated
  def test_driver_move
    museum_id = 3
    
    expected_location = museum_id
    actual_location = @driver.move
    assert_equal expected_location, actual_location
  end
  
  # This tests that the driver's movement's is printed out
  def test_driver_movement_print
    expected_print = "Driver #{@driver_id} heading from #{@map.location_name 1} to #{@map.location_name 1} via Bar St.\n"
    
    assert_output(expected_print) { @driver.move }
  end
  
  
  # UNIT TESTS FOR METHOD update_driver_items
  # Equivalence classes:
  # The drivers items is updated if necessary (i.e. the driver's toy, book, and class count is updated accordingly)
  
  # This tests that a driver's toy, book, and class count is updated by the return value of 
  # check_for_classes, check_for_books, and check_for_toys. Since the aforementioned methods are stubbed in this test,
  # the value of driver's book, toy, and class count should all be 1 since that's what our stub method returns.
  def test_update_driver_item  
    @driver.update_driver_items
    
    expected_count = 1
    
    assert_equal expected_count, @driver.books
    assert_equal expected_count, @driver.toys
    assert_equal expected_count, @driver.classes
  end
  
end