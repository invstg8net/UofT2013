class Name < Field
    set_table_name "name"
    attr_accessible :name

    def GetName()
	if (self.hidden == true)    	
		return 'John Doe'
	else	
		return self.name
	end
    end
    
    def SetName(name)
        self.name = name
    end

end
