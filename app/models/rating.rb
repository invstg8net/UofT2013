class Rating < Field
  attr_accessor :rating

  def initialize
    @rating = 0
    @n = 0
    @hidden = false
  end

  # Fetch the rating of the researcher if made visible 
  def GetRating()
    if (self.hidden == true)    	
      return ''
    else	
      return self.rating
    end
  end

  # This will be used by an algorithm to constantly change the rating of a researcher
  def UpdateRating(point)
    @n += 1
    @rating = (@rating + point) / n
  end
  
end
