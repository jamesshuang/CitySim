class Location
  
  attr_accessor :avenue
  attr_accessor :street
  attr_accessor :id
  attr_accessor :name
  
  def initialize name, id
    @name = name
    @id = id
    @avenue = nil
    @street = nil 
  end
  
  #move randomly to street or avenue
  #generator random number 0 or 1. 
  #if 0, take avenue, if 1, take street
  def move_to_random random
    if random == 0 
      return @avenue.destination, @avenue.name
    elsif random == 1
      return @street.destination, @street.name
    else
      raise "Invalid random number"
    end
  end
  
end