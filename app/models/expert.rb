class Expert < ActiveRecord::Base

belongs_to :user
attr_accessible :active, :topic, :researcher_count
attr_accessor :hidden

#Retrieve area of expertise for the researcher
def GetExpertise()
    if (self.hidden == true)
	return nil
    else
	return self.topic
    end
end

#Allow the user to change his area of expertise
#However with the current implementation, only 4 possible fields are
#allowed, will need further refactoring
def SetExpertise(topic)
    if (['News, Sciences, Politics, Weather'].include? topic)
	self.topic = topic
    else
        puts "Field can only be News, Sciences, Politics, or Weather"
    end
end

def HideExpertise()
    self.hidden = true;
end
def ShowExpertise()
    self.hidden = false;
end

end

