class Name < Field
    
    attr_writer :name

    def getName()
	if (self.hidden == 0)    	
		return nil
	else	
		return @name
	end
    end

end
