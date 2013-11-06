#require 'researcher'
require 'test/unit'
require 'active_record'
require './name'
require './field'
require './maxquestion'
require './status'
require './textcap'
require './time'
require './phone'
require './rating'
require './expert'

class Test_Suite < Test::Unit::TestCase

	def setup
	    	@name = Name.new
		@expert = Expert.new
		@rating = Rating.new
		@phone = Phone.new 
		@status = Status.new
		@maxquestion = QuestionCap.new
		@textlengthcap = TextLengthCap.new
	       #@researcher = Researcher.new
	end

	def teardown
	end
#1
	def test_CreateName
		assert_equal @name.GetName, nil
	end
#2
	def test_UpdateName
		@name.SetName("Dave")
		assert_equal @name.GetName, "Dave"
	end
#3
	def test_CreateExpertise
		assert_equal @expert.GetExpertise, nil
	end
#4
	def test_UpdateExpertise
		@expert.SetExpertise("Sciences")
		assert_equal @expert.GetExpertise, "Sciences"
	end
#5
	def test_ExpertiseDoesNotExist
		@expert.SetExpertise("Emotions")
		#This test will output a message to show that it detected a non-existing field
		assert_equal @expert.GetExpertise, nil
	end
#6	
	def test_CreateRating
		assert_equal @rating.GetRating, nil
	end
#7
	def test_UpdateRating
		@rating.SetRating("3")
		assert_equal @rating.GetRating, "3"
	end
#8
	def test_CreatePhone
		assert_equal @phone.GetPhone, nil
	end
#9
	def test_UpdatePhone
		@phone.SetPhone("4161234567")
		assert_equal @phone.GetPhone, "4161234567"
	end
#10	
	def test_CreateStatus
		assert_equal @status.GetStatus, nil
	end
#11
	#Postcondition : Display Permanently Banned
	def test_UpdateStatusBanned
		@status.SetStatus(-1)
		assert_equal @status.GetStatus, "Permanently Banned"
	end
#12
	#Postcondition : Display Good Standing
	def test_UpdateStatusGoodStanding
		@status.SetStatus(0)
		assert_equal @status.GetStatus, "Good Standing"
	end
#13
	#PostCondtion : Returns number of days suspended
	def test_UpdateStatusSuspended
		@status.SetStatus(25)
		assert_equal @status.GetStatus, 25
	end
#14
	def test_CreateMaxQuestion
		assert_equal @maxquestion.GetQuestionCap, nil
	end
#15
	def test_UpdateMaxQuestion
		@maxquestion.SetQuestionCap(4)
		assert_equal @maxquestion.GetQuestionCap, 4
	end
#16
	def test_CreateTextLengthCap
		assert_equal @textlengthcap.GetTextLengthCap, nil
	end
#17
	def test_UpdateTextLengthCap
		@textlengthcap.SetTextLengthCap(145)
		assert_equal @textlengthcap.GetTextLengthCap, 145
	end
end
