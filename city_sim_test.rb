require 'minitest/autorun'
require_relative 'city_sim'

class CitySimTest < Minitest::Test
  
  def setup
    seed = ['0']
    @city_sim = CitySim::new seed
  end
  
  # UNIT TESTS FOR METHOD run
  # Equivalence classes:
  # @driver_number = 1 -> 6 (one less than max number of drivers)
  
  # This tests that @driver_number will always be 6 (one less than max number of drivers) when the method returns
  def test_max_driver_number
    @city_sim.run
    
    expected_drivers = 6
    actual_drivers = @city_sim.driver_number
    assert_equal expected_drivers, actual_drivers
  end
  
  # UNIT TESTS FOR METHOD driver_iteration
  # Equivalence classes:
  # driver_exited = false -> returns true
  
  # This tests that driver_exited will always be true when the method returns. 
  def test_driver_iteration
    actual_driver_exited = @city_sim.driver_iteration
    expected_driver_exited = true
    
    assert_equal expected_driver_exited, actual_driver_exited
  end
  
  # UNIT TESTS FOR METHOD check_for_exit next_place, driver
  # Equivalence classes:
  # next_place = 4 or 5 -> returns true
  # next_place != 4 or 5 -> returns false
  # next_place is not an integer value -> return false
  
  # If next_place is 4 or 5 (location id of downtown and monroeville), return true
  def test_for_exit
    driver = Minitest::Mock.new "driver"
    
    def driver.books; 1; end
    def driver.toys; 1; end
    def driver.classes; 1; end
    def driver.number; 1; end
    
    expected = true
    actual_for_4 = @city_sim.check_for_exit 4, driver
    assert_equal expected, actual_for_4
    
    actual_for_5 = @city_sim.check_for_exit 5, driver
    assert_equal expected, actual_for_5
  end
  
  # If next_place is not 4 or 5 (location id of downtown and monroeville), return false 
  def test_for_no_exit
    driver = Minitest::Mock.new "driver"
    
    def driver.books; 1; end
    def driver.toys; 1; end
    def driver.classes; 1; end
    def driver.number; 1; end
    
    expected = false
    actual_for_0 = @city_sim.check_for_exit 0, driver
    assert_equal expected, actual_for_0
    
    actual_for_100 = @city_sim.check_for_exit 100, driver
    assert_equal expected, actual_for_100
  end
  
  # If next_place is a non-integer value, return false
  # EDGE CASE
  def test_for_non_integer_exit
    driver = Minitest::Mock.new "driver"
    
    def driver.books; 1; end
    def driver.toys; 1; end
    def driver.classes; 1; end
    def driver.number; 1; end
    
    expected = false
    actual_for_non_integer = @city_sim.check_for_exit "foobar", driver
    assert_equal expected, actual_for_non_integer
  end
end