class Rating < ActiveRecord::Base
    attr_accessible :rating
    attr_accessor :hidden
    # Fetch the rating of the researcher if made visible 
    def GetRating()
	if (self.hidden == true)    	
		return ''
	else	
		return self.rating
	end
    end
    # This will be used by an algorithm to constantly change the rating of a researcher
    def SetRating(rating)
        self.rating = Rating
    end
  
end
