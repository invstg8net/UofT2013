class QuestionCap < Field
    set_table_name "max_question"
    attr_accessible :max_question

    def GetQuestionCap()
	return self.max_question
    end
      
    def SetQuestionCap(threshold)
        self.QuestionCap = threshold
    end
end
