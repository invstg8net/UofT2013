class Message < ActiveRecord::Base
	belongs_to :researcher

	attr_accessible :sender, :researcher_id, :message


	def updateBody(text)
		self.body = text
	end
end
