class QuestionCap < Field
    attr_accessor :max_question

    def GetQuestionCap()
	return self.max_question
    end
      
    def SetQuestionCap(threshold)
        self.max_question = threshold
    end

end
