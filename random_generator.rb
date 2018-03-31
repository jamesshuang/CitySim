class RandomGenerator
  
  def validate_seed seed
    raise "Enter a seed and only a seed" unless seed.count == 1
    
    begin
      @seed = Integer(seed[0])
    rescue
      @seed = 0
    end
    
    @generator = Random.new @seed
  end
  
  def spawn_location
    range = 4
    @generator.rand range
  end
  
  def next_step
    range = 2
    @generator.rand range
  end
  
end