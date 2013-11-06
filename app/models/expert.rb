class Expert < Field
 
#belongs_to :user
attr_accessor :active, :topic, :researcher_count

def GetExpertise()
	if (self.hidden == true)    	
		return nil
	else	
		return self.topic
	end
end

def SetExpertise(topic)
    #Checks if the topic provided is a valid field of research
    if (['News', 'Sciences', 'Politics', 'Weather', 'Mining', 'Astronomy'].include? topic)
	self.topic = topic
    else
        puts " Field can only be News, Sciences, Politics, Weather, Mining, or Astronomy"
    end
end
end

