class Phone < Field

    attr_writer :phone

    def getPhone(isColab)
	if (self.hidden == 2)    	
		return @phone
	elsif (self.hidden == 1 and isColab)	
		return @phone
	else
		return nil
	end
    end
    
end
