class Privacy < ActiveRecord::Base
    
    belongs_to :researcher

	attr_accessible :namepriv, :emailpriv, :phonepriv, :expertisepriv

	#0 = private
	#1 = semi-private (friends?)
	#2 = public

	validates_presence_of :namepriv
	validates_presence_of :emailpriv
	validates_presence_of :phonepriv
	validates_presence_of :expertisepriv

	def updateSettingsName(val)
		self.namepriv = val
	end

	def updateSettingsEmail(val)
		self.emailpriv = val
	end

	def updateSettingsPhone(val)
		self.phonepriv = val
	end

	def updateSettingsExpertise(val)
		self.expertisepriv = val
	end
end