require 'minitest/autorun'
require_relative 'city_map'

class CityMapTest < Minitest::Test
  
  def setup
    @dummy_generator = Minitest::Mock.new "Dummy Generator"
    
    @map = CityMap::new @dummy_generator
  end
  
  # UNIT TESTS FOR METHOD next_location current_location
  # Equivalence classes:
  # current_location is an integer value that is equal to the location ID of hospital, cathy, 
  # hillman, or museum -> returns next location and name of road to get there
  # current_location is an integer value that is not equal to the location ID of hospital, cathy, 
  # hillman, or museum -> raises RuntimeError with message "Invalid location ID"
  # current_location is not an integer value -> raises RuntimeError with message "Invalid location ID"
  # Note: the location ID of hospital, cathy, hillman, and museum is set to: 0, 1, 2, 3 (respectively)
  
  # If current_location is an integer value that is equal to the location ID of hospital, cathy, hillman or museum,
  # then return the next location to traverse to and the name of the road to get there.
  def test_valid_integer_argument
    def @dummy_generator.next_step; 1; end
    
    # Pass Cathy ID as our current location. Dummy generator should take us to Museum via Bar St.
    next_location, name = @map.next_location 1
    expected_location = 3
    expected_name = "Bar St."
    assert_equal expected_location, next_location
    assert_equal expected_name, name
  end
  
  # If current_location is an integer value that is not equal to the location ID of hospital, cathy, hillman or museum,
  # then raises RuntimeError with message "Invalid location ID"
  def test_invalid_integer_argument
    def @dummy_generator.next_step; 1; end
    
    invalid_integer_id = 4
    
    assert_raises RuntimeError do
      @map.next_location invalid_integer_id
    end
  end
  
  # If current_location is not an integer value,
  # then raises RuntimeError with message "Invalid location ID"
  # EDGE CASE
  def test_non_integer_argument
    def @dummy_generator.next_step; 1; end
    
    non_integer_argument = "foobar"
    
    assert_raises RuntimeError do 
      @map.next_location non_integer_argument
    end
  end
  
  # UNIT TESTS FOR METHOD location_name location
  # Equivalence classes:
  # location is an integer value that is equal to the location ID of hospital, cathy,
  # hillman, museum, downtown, or monroeville -> returns string containing name of the location
  # location is an integer value that is not equal to the location ID of hospital, cathy,
  # hillman, museum, downtown, or monroeville -> raises RuntimeError with message "Invalid location ID"
  # location is not an integer value -> raises RuntimeError with message "Invalid location ID"

  # If location is an integer value that is equal to the location ID of hospital, cathy, hillman,
  # museum, downtown, or monroeville, then return string containing name of the location 
  def test_valid_integer_argument_for_name
    valid_integer_id = 0 #integer ID for hospital
    
    expected_name = "Hospital"
    actual_name = @map.location_name valid_integer_id
    
    assert_equal expected_name, actual_name
  end
  
  # If location is an integer value that is not equal to the location ID of hospital, cathy, 
  # hillman, museum, downtown, or monroeville, then raise RuntimeError with message "Invalid location ID"
  def test_invalid_integer_argument_for_name
    invalid_integer_id = -1
    
    assert_raises RuntimeError do
      @map.location_name invalid_integer_id
    end
  end
  
  # If location is not an integer value, then raise RuntimeError with message "Invalid location ID"
  # EDGE CASE
  def test_non_integer_argument_for_name
    non_integer_argument = "foobar"
    
    assert_raises RuntimeError do 
      @map.location_name non_integer_argument
    end
  end

  # UNIT TESTS FOR METHOD check_for_classes current, location
  # Equivalence classes:
  # current is an integer value, location is a integer value that is equal to the location ID
  # of cathy -> returns current argument multiplied by 2 (i.e. returns current = current * 2)
  # current is not an integer value, location is a integer value that is equal to the location ID
  # of cathy -> raises RuntimeError with message "Invalid argument for current parameter"
  # current is an integer value, location is not an integer value that is equal the location ID
  # of cathy -> returns unmodified current argument
  # current is not an integer value, location is not an integer value that is not equal to the location ID
  # of cathy -> raises RuntimeError with message "Invalid argument for current parameter"
  
  # If current is an integer value, and location is an integer value that is equal to the location ID of cathy,
  # then return current argument multiplied by 2 (i.e. return current = current * 2)
  def test_valid_arguments_for_classes
    current = 2
    cathy_id = 1
    
    actual_current = @map.check_for_classes current, cathy_id
    expected_current = current * 2
    
    assert_equal expected_current, actual_current
  end
  
  # If current is not an integer value, and location is a integer value that is not equal to the location ID of cathy,
  # then raise RuntimeError with message "Invalid argument for current parameter"
  # EDGE CASE
  def test_invalid_current_invalid_location_integer_for_classes
    current = "foobar"
    location = -1
    
    assert_raises RuntimeError do 
      @map.check_for_classes current, location
    end
  end
  
  # If current is an integer value, and location is not an integer value that is equal to the location ID of cathy,
  # then return unmodified current argument
  def test_valid_current_non_integer_location_for_classes
    current = 1
    location = "foobar"
    
    actual_current = @map.check_for_classes current, location
    expected_current = current
    
    assert_equal expected_current, actual_current
  end
  
  # If current is not an integer value, and location is not an integer value that is equal to the location ID of cathy,
  # then raise RuntimeError with message "Invalid argument for current parameter"
  # EDGE CASE
  def test_invalid_current_non_integer_location_for_classes
    current = "foo"
    location = "bar"
    
    assert_raises RuntimeError do 
      @map.check_for_classes current, location 
    end
  end
    
  # UNIT TESTS FOR METHOD check_for_books current, location
  # Equivalence classes:
  # current is an integer value, location is a integer value that is equal to the location ID
  # of hillman -> returns current argument incremented by 1 (i.e. returns current = current + 1)
  # current is not an integer value, location is a integer value that is equal to the location ID
  # of hillman -> raises RuntimeError with message "Invalid argument for current parameter"
  # current is an integer value, location is not an integer value that is equal the location ID
  # of hillman -> returns unmodified current argument
  # current is not an integer value, location is not an integer value that is not equal to the location ID
  # of hillman -> raises RuntimeError with message "Invalid argument for current parameter"
  
  # If current is an integer value, and location is an integer value that is equal to the location ID of hillman,
  # then return current argument incremented by 1 (i.e. return current = current + 1)
  def test_valid_arguments_for_books
    current = 1
    hillman_id = 2
    
    actual_current = @map.check_for_books current, hillman_id
    expected_current = current + 1
    
    assert_equal expected_current, actual_current
  end
  
  # If current is not an integer value, and location is a integer value that is not equal to the location ID of hillman, 
  # then raise RuntimeError with message "Invalid argument for current parameter"
  # EDGE CASE
  def test_invalid_current_invalid_location_integer_for_books
    current = "foobar"
    location = -1
    
    assert_raises RuntimeError do 
      @map.check_for_books current, location
    end
  end
  
  # If current is an integer value, and location is not an integer value that is equal to the location ID of hillman,
  # then return unmodified current argument
  def test_valid_current_non_integer_location_for_books
    current = 1
    location = "foobar"
    
    actual_current = @map.check_for_books current, location
    expected_current = current
    
    assert_equal expected_current, actual_current
  end
  
  # If current is not an integer value, and location is not an integer value that is equal to the location ID of hillman,
  # then raise RuntimeError with message "Invalid argument for current parameter"
  # EDGE CASE
  def test_invalid_current_non_integer_location_for_books
    current = "foo"
    location = "bar"
    
    assert_raises RuntimeError do 
      @map.check_for_books current, location 
    end
  end
  
  # UNIT TESTS FOR METHOD check_for_toys current, location
  # Equivalence classes:
  # current is an integer value, location is a integer value that is equal to the location ID
  # of museum -> returns current argument incremented by 1 (i.e. returns current = current + 1)
  # current is not an integer value, location is a integer value that is equal to the location ID
  # of museum -> raises RuntimeError with message "Invalid argument for current parameter"
  # current is an integer value, location is not an integer value that is equal the location ID
  # of museum -> returns unmodified current argument
  # current is not an integer value, location is not an integer value that is not equal to the location ID
  # of museum -> raises RuntimeError with message "Invalid argument for current parameter"
  
  # If current is an integer value, and location is an integer value that is equal to the location ID of museum,
  # then return current argument incremented by 1 (i.e. return current = current + 1)
  def test_valid_arguments_for_toys
    current = 1
    museum_id = 3
    
    actual_current = @map.check_for_toys current, museum_id
    expected_current = current + 1
    
    assert_equal expected_current, actual_current
  end
  
  # If current is not an integer value, and location is a integer value that is not equal to the location ID of museum, 
  # then raise RuntimeError with message "Invalid argument for current parameter"
  # EDGE CASE
  def test_invalid_current_invalid_location_integer_for_toys
    current = "foobar"
    location = -1
    
    assert_raises RuntimeError do 
      @map.check_for_toys current, location
    end
  end
  
  # If current is an integer value, and location is not an integer value that is equal to the location ID of museum,
  # then return unmodified current argument
  def test_valid_current_non_integer_location_for_toys
    current = 1
    location = "foobar"
    
    actual_current = @map.check_for_toys current, location
    expected_current = current
    
    assert_equal expected_current, actual_current
  end
  
  # If current is not an integer value, and location is not an integer value that is equal to the location ID of museum,
  # then raise RuntimeError with message "Invalid argument for current parameter"
  # EDGE CASE
  def test_invalid_current_non_integer_location_for_toys
    current = "foo"
    location = "bar"
    
    assert_raises RuntimeError do 
      @map.check_for_toys current, location 
    end
  end
  
end