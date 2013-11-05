class TimeSlot < Field

    attr_accessible :start_time, :end_time
   
    #This method returns a boolean true or false, if the time
    #time provided is in the time slot provided by the user
    #then it'll return true
    def ableToSend(time)
        if (time > self.start_time && time < self.end_time)
            return true
        else
            return false
        end
    end

    #This method will fetch the available time provided by the user 
    #on account creation
 
    def getTimeSlot()
	return ("Able to send in between ? and ?", self.start_time, self.end_time)
    end

    #This method will be used to set/update the users available start time and end time
   
    def setTimeSlot(starttime, endtime)
	if (starttime < 0 || endtime > 24)
	    return "Incorrect Time Slot Provided Please use the 24 hour system"
	else
	    self.start_time = starttime
	    self.end_time = endtime
	end

    end
end

