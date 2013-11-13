class Email < Field
    
    attr_writer :email
    
    def GetPhone()
        if (self.hidden == true)
            return nil
            else
            return self.email
        end
    end
    
end
