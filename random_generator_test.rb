require 'minitest/autorun'
require_relative 'random_generator'

class RandomGeneratorTest < Minitest::Test
  
  # UNIT TESTS FOR METHOD validate_seed seed
  # Equivalence classes:
  # seed.count != 1, seed[0] is not an integer value -> raises RuntimeError with message "Enter a seed and only a seed"
  # seed.count != 1, seed[0] is a integer value -> raises RuntimeError with message "Enter a seed and only a seed"
  # seed.count == 1, seed[0] is not an integer value -> returns a new Random class with 0 as the seed
  # seed.count == 1, seed[0] is an integer value -> returns a new Random class with seed[0] as the seed
  
  # If seed.count is not 1 and first element in seed array is not an integer value,
  # then raise a RuntimeError with the message "Enter a seed and only a seed"
  def test_invalid_arg_count_and_invalid_seed
    seed = ['foo', 'bar']
    
    generator = RandomGenerator::new
    
    assert_raises RuntimeError do
      generator.validate_seed seed
    end
  end
  
  # If seed.count is not 1 and first element in seed array is an integer value,
  # then raise a RuntimeError with the message "Enter a seed and only a seed"
  def test_invalid_arg_count_and_valid_seed 
    seed = [0, 'bar']
    
    generator = RandomGenerator::new
    
    assert_raises RuntimeError do
      generator.validate_seed seed
    end
  end
  
  # If seed.count is 1 and first element in seed array is not an integer value,
  # then return a new Random class with 0 as the seed
  def test_valid_arg_count_and_invalid_seed
    seed = ['foo']
    
    generator = RandomGenerator::new

    actual_return = generator.validate_seed seed
    expected_return = Random::new 0
    
    assert_equal expected_return, actual_return
  end
  
  # If seed.count is 1 and first element in seed array is an integer value,
  # then return a new Random class with first element in seed array as the seed
  def test_valid_arg_count_and_valid_seed 
    seed = ['1']
    
    generator = RandomGenerator::new

    actual_return = generator.validate_seed seed
    expected_return = Random::new Integer(seed.first)
    
    assert_equal expected_return, actual_return
  end
  
  # UNIT TESTS FOR METHOD spawn_location
  # Equivalence classes:
  # Integer value 4 is passed as range to Random generator -> returns random number between 0-3 (inclusive)
  
  # This tests that method returns a random number between 0-3 (inclusive)
  def test_generate_random_num_between_0_3
    generator = RandomGenerator::new
    seed = [0]
    generator.validate_seed seed
    
    actual_num = generator.spawn_location
    expected_num = [0, 1, 2, 3] #collection of expected return values
    
    assert_includes expected_num, actual_num
  end
  
  # UNIT TESTS FOR METHOD next_step
  # Equivalence classes:
  # Integer value 2 is passed as range to Random generator -> returns random number 0 or 1
  
  # This tests that methods returns a 0 or 1
  def test_generate_random_num_between_0_1
    generator = RandomGenerator::new
    seed = [0]
    generator.validate_seed seed
    
    actual_num = generator.next_step
    expected_num = [0, 1] #collection of expected return values
    
    assert_includes expected_num, actual_num
  end
end