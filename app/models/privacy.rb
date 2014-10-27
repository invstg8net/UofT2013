class Privacy < ActiveRecord::Base
    
    belongs_to :researcher

	attr_accessible :pseudonympriv, :regionpriv, :twitterpriv, :namepriv, :emailpriv, :phonepriv, :expertisepriv
	
	#0 = private
	#1 = semi-private (friends?)
	#2 = public

	# validates_presence_of :namepriv
	# validates_presence_of :emailpriv
	# validates_presence_of :phonepriv
	# validates_presence_of :expertisepriv

end