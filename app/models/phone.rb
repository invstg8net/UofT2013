class Phone < Field

    attr_accessor :phone

    def GetPhone()
	if (self.hidden == true)    	
		return nil
	else	
		return self.phone
	end
    end
    
    def SetPhone(phone)
        self.phone = phone
    end
end
