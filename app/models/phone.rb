class Phone < Field

    attr_writer :phone

    def GetPhone()
	if (self.hidden == true)    	
		return nil
	else	
		return self.phone
	end
    end
    
end
