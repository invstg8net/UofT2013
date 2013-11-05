class QuestionCap < Field
    set_table_name "max_question"
    attr_accessible :max_question

    def GetQuestionCap()
	return self.max_question
    end
      
    def SetQuestionCap(threshold)
        self.max_question = threshold
    end

end
