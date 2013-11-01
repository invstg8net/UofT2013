class Name < Field
    set_table_name "name"
    attr_accessible :name

    # When retrieving the name of the reseracher, must find a way to create a temporary anonymous name which can
    # link two users after they have made contact with each other depending on the level of visibility selected
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
