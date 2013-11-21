class Email < Field
    
    attr_writer :email
    
    def getEmail()
        if (self.hidden == 0)
            return nil
            else
            return @email
        end
    end
    
end
