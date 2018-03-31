require_relative 'city_map'

class Driver
  
  attr_accessor :classes
  attr_accessor :books
  attr_accessor :toys
  attr_accessor :number
  
  def initialize starting_location, map, number
    @current_location = starting_location
    @map = map
    @number = number
    
    @classes = 1
    @books = 0
    @toys = 0
    
    update_driver_items
  end
  
  def move
    next_place, road = @map.next_location @current_location
    
    puts "Driver #{@number} heading from #{@map.location_name @current_location} to #{@map.location_name next_place} via #{road}"
    
    @current_location = next_place
    
    update_driver_items
    
    return @current_location
  end
  
  def update_driver_items
    @classes = @map.check_for_classes @classes, @current_location
    @books = @map.check_for_books @books, @current_location
    @toys = @map.check_for_toys @toys, @current_location
  end
  
end