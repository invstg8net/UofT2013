class TextLengthCap < Field
    set_table_name "length_cap"
    attr_accessible :length_cap

    def GetTextLengthCap()
	return self.length__cap
    end
      
    def SetTextLengthCap(threshold)
        self.length_cap = threshold
    end

end
