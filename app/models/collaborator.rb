class Collaborator < ActiveRecord::Base
	#a "friend list" for a researcher. collab_id is the id of a researcher who is a friend
	belongs_to :researcher

	attr_accessible :researcher_id, :collab_id, :confirmed

	validates_presence_of :collab_id
	validates_presence_of :confirmed

  def show
    Collaborator.columns.each {|col| print send(col.name), "\t"}
  end

  def Collaborator.show_all
    find(:all).each { |collaborator| collaborator.show; puts}
  end
end
