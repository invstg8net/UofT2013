class Email < Field
    
    attr_writer :email
    
    def getEmail(isColab)
		if (self.hidden == 2)    	
			return @email
		elsif (self.hidden == 1 and isColab)	
			return @name
		else
			return nil
		end
    end
    
end
