class Phone < Field

    attr_writer :phone

    def getPhone()
	if (self.hidden == 0)    	
		return nil
	else	
		return @phone
	end
    end
    
end
