class Phone < Field
    set_table_name "phone"
    attr_accessible :phone

    def GetPhone()
	if (self.hidden == true)    	
		return nil
	else	
		return self.phone
	end
    end
    
    def SetPhone(Phone)
        self.phone = phone
    end
end
