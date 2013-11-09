# require './field'

class Name < Field

    attr_accessor :name

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
