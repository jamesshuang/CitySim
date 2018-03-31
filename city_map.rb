require_relative 'location'
require_relative 'road'

class CityMap
  
  attr_accessor :monroeville
  attr_accessor :downtown
  
  def initialize random_generator
    @generator = random_generator
    
    fourth = "Fourth Ave."
    fifth = "Fifth Ave."
    foo = "Foo St."
    bar = "Bar St."
    
    @hospital = Location::new "Hospital", 0 #0
    @cathy =  Location::new "Cathedral", 1 #1
    @hillman = Location::new "Hillman", 2 #2
    @museum = Location::new "Museum", 3 #3
    
    @monroeville = Location::new "Monroeville", 4 #4
    @downtown = Location::new "Downtown", 5 #5
    
    hospital_ave = Road::new fourth, @cathy.id
    hospital_st = Road::new foo, @hillman.id
    @hospital.avenue = hospital_ave
    @hospital.street = hospital_st
    
    cathy_ave = Road::new fourth, @monroeville.id
    cathy_st = Road::new bar, @museum.id
    @cathy.avenue = cathy_ave
    @cathy.street = cathy_st 
    
    hillman_ave = Road::new fifth, @downtown.id
    hillman_st = Road::new foo, @hospital.id
    @hillman.avenue = hillman_ave
    @hillman.street = hillman_st
    
    museum_ave = Road::new fifth, @hillman.id
    museum_st = Road::new bar, @cathy.id
    @museum.avenue = museum_ave
    @museum.street = museum_st
  end
  
  def next_location current_location
    random = @generator.next_step
    
    case current_location
    when @hospital.id
      next_place, road = @hospital.move_to_random random
    when @cathy.id
      next_place, road = @cathy.move_to_random random
    when @hillman.id
      next_place, road = @hillman.move_to_random random
    when @museum.id
      next_place, road = @museum.move_to_random random
    else
      raise "Invalid location ID"
    end
  end
  
  def location_name location
    case location
    when @hospital.id
      "Hospital"
    when @cathy.id
      "Cathedral"
    when @hillman.id
      "Hillman"
    when @museum.id
      "Museum"
    when @monroeville.id
      "Monroeville"
    when @downtown.id
      "Downtown"
    else 
      raise "Invalid location ID"
    end
  end
  
  def check_for_classes current, location
    raise "Invalid argument for current parameter" unless current.is_a? Integer
    if location == @cathy.id
      current = current * 2
    else 
      current
    end
  end
  
  def check_for_books current, location
    raise "Invalid argument for current parameter" unless current.is_a? Integer
    if location == @hillman.id
      current = current + 1
    else
      current 
    end
  end
  
  def check_for_toys current, location
    raise "Invalid argument for current parameter" unless current.is_a? Integer
    if location == @museum.id
      current = current + 1
    else 
      current 
    end 
  end
  
end