class Status < Field
    attr_accessor :acct_status

    def GetStatus()
	if (self.acct_status == nil)
		return nil
	end
	if (self.acct_status < 0)
	    return "Permanently Banned"
	elsif (self.acct_status > 0)
	    return self.acct_status
	else
	    return "Good Standing"
       end
    end   
    def SetStatus(days)
        self.acct_status = days
    end
end
