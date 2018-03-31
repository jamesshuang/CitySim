require_relative 'city_map'
require_relative 'driver'
require_relative 'random_generator'
require_relative 'plural_converter'

class CitySim
  
  attr_accessor :driver_number

  def initialize seed
    @random_generator = RandomGenerator::new
    @random_generator.validate_seed seed

    @city_map = CityMap::new @random_generator
    @converter = PluralConverter::new
  end
  
  def run
    @driver_number = 1
    max_drivers = 6
    until @driver_number == max_drivers
      driver_iteration
      @driver_number += 1
    end
  end
  
  def driver_iteration
    driver = Driver::new @random_generator.spawn_location, @city_map, @driver_number
    
    driver_exited = false
    until driver_exited
      next_place = driver.move 
      driver_exited = check_for_exit next_place, driver
    end
    driver_exited
  end
  
  def check_for_exit next_place, driver
    if next_place == @city_map.monroeville.id || next_place == @city_map.downtown.id        
      puts "Driver #{driver.number} obtained #{driver.books} #{@converter.pluralize driver.books, "book"}!"
      puts "Driver #{driver.number} obtained #{driver.toys} #{@converter.pluralize driver.toys, "toy"}!"
      puts "Driver #{driver.number} attended #{driver.classes} #{@converter.pluralize driver.classes, "class"}!"
      true
    else
      false
    end
  end
end