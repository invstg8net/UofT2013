class Name < Field
    
    attr_writer :name

    def getName(isColab)
	if (self.hidden == 2)    	
		return @name
	elsif (self.hidden == 1 and isColab)	
		return @name
	else
		return nil
	end
    end

end
