class TextLengthCap < Field
    attr_accessor :length_cap

    def GetTextLengthCap()
	return self.length_cap
    end
      
    def SetTextLengthCap(threshold)
        self.length_cap = threshold
    end

  # send an sms message with the body sendMessage, to the phone number sendTo
  # checks the length of the message to be sent, if length exceeds the user requested
  # length, send 
    def send(sendMessage, sendTo)
    
        message_length = sendMessage.length()

        #Each text has 145 characters
    	number_texts = message_length/145

    	#Message to be sent
    	sent_message = nil

    	#Checks the text capacity of the account
    	if (number_texts > self.length_cap)
      	    sent_message = "The number of texts that this message will send exceeds the number of your accounts capacity"
    	else
      	    sent_message = sendMessage 
	end
    end
end
