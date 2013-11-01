#Generic Field Object, some fields that inherit the Field class may not require the hidden attribute
class Field < ActiveRecord::Base

    attr_accessor :hidden
    #Hide the specific field, each class that inherits from Field will have their own way of handling
    #anonymity
    def Hide()
	self.hidden = true;    
    end

    def Show()
	self.hidden = false;
    end

end
