class Status < Field
    set_table_name "account status"
    attr_accessible :acct_status

    def GetStatus()
	if (self.acct_status < 0)
	    return "Permanently Banned"
	elsif (self.acct_status = 0)
	    return "Good Standing"
	else
	    return self.acct_status
    end
      
    def SetStatus(days)
        self.acct_status = daysS
    end
end
