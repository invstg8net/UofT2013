class Name < Field
    
    attr_writer :name

    def GetName()
	if (self.hidden == true)    	
		return 'John Doe'
	else	
		return self.name
	end
    end

end
