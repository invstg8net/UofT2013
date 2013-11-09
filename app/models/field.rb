class Field < ActiveRecord::Base

    attr_accessor :hidden
    
    def Hide()
	self.hidden = true;    
    end

    def Show()
	self.hidden = false;
    end

end
