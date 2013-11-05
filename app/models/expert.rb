class Expert < ActiveRecord::Base

belongs_to :user
attr_accessible :active, :topic, :researcher_count

def GetExpertise()
	return self.topic
end

def SetExpertise(topic)
    if (['News, Sciences, Politics, Weather'].include? topic)
	self.topic = topic
    else
        puts "Field can only be News, Sciences, Politics, or Weather"
    end
end
end

