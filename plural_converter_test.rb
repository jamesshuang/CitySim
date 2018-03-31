require 'minitest/autorun'
require_relative 'plural_converter'

class PluralConverterTest < Minitest::Test
  
  def setup
    @converter = PluralConverter::new
  end
  
  # UNIT TESTS FOR METHOD pluralize item_count, item
  # Equivalence classes:
  # item_count= -INFINITY..1 and item_count is not 0, item ends with character "s" -> returns unmodified item parameter 
  # item_count= -INFINITY..1 and item_count is not 0, item does not end with character "s" -> returns unmodified item parameter 
  # item_count= 0, item ends with character "s" -> returns item parameter with string "es" appended at the end
  # item_count= 0, item ends does not end with character "s" -> returns item parameter with string "s" appended at the end
  # item_count= 2..INFINITY, item ends with character "s" -> returns item parameter with string "es" appended at the end
  # item_count= 2..INFINITY, item does not end with character "s" -> returns item parameter with string "s" appended at the end
  
  # If item_count is less than 2 and is not 0, and item ends with "s" character,
  # then return unmodified item parameter
  def test_non_plural_with_s
    item = "class"
    item_count = 1
    converted_item = @converter.pluralize item_count, item
    
    assert_equal item, converted_item
  end
  
  # If item_count is less than 2 and is not 0, and item does not end with "s" character,
  # then return unmodified item parameter
  def test_non_plural_without_s
    item = "book"
    item_count = 1
    converted_item = @converter.pluralize item_count, item
    
    assert_equal item, converted_item
  end 
  
  # If item_count is 0 and item parameter ends with character "s", then return item parameter with "es" appended at the end
  def test_0_with_s 
    item = "class"
    item_count = 0
    converted_item = @converter.pluralize item_count, item
    expected_return = item + "es"
    
    assert_equal expected_return, converted_item
  end 
  
  # If item_count is 0 and item parameter ends does not with character "s", then return item parameter with "s" appended at the end
  def test_0_without_s 
    item = "book"
    item_count = 0
    converted_item = @converter.pluralize item_count, item
    expected_return = item + "s"
    
    assert_equal expected_return, converted_item
  end 
  
  # If item_count is more than 1 and item ends with "s" character,
  # then return item parameter with string "es" appended at the end
  def test_plural_with_s 
    item = "class"
    item_count = 2
    converted_item = @converter.pluralize item_count, item
    expected_return = item + "es"
    
    assert_equal expected_return, converted_item
  end 
  
  # If item_count is more than 1 and item does not end with "s" character,
  # then return item parameter with string "s" appended at the end
  def test_plural_without_s
    item = "book"
    item_count = 2
    converted_item = @converter.pluralize item_count, item
    expected_return = item + "s"
    
    assert_equal expected_return, converted_item    
  end
  
end