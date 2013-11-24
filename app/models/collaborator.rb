class Collaborator < ActiveRecord::Base
	#a "friend list" for a researcher. collab_id is the id of a researcher who is a friend
	belongs_to :researcher

	attr_accessible :collab_id, :confirmed

	validates_presence_of :collab_id
	validates_presence_of :confirmed
end