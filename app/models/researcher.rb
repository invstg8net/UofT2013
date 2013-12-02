class Researcher < ActiveRecord::Base
  has_many :answers
  has_one :privacy
  has_many :collaborators
  has_many :messages

attr_accessible :email, :password, :password_confirmation, :status, :name, :region, :pseudonym, :twitter, :phone_number, :mobile_number, :Is_Admin, :max_questions, :textcap, :rating, :rating_n

#status -1 = ban, 0 = unactivated, 1 = active

  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :phone_number
  validates_uniqueness_of :email
  
  def setPrivacy
      if self.privacy.nil?
          self.create_privacy
      end
  end

  def getName(asker)
    if (self.privacy.namepriv == 2 or asker.Is_Admin)     #public
      return self.name
    elsif (self.privacy.namepriv == 1 and inCollaborators(asker))  #available to collaborators
      return self.name
    elsif (asker == self)   #displaying for self
      return self.name
    else
      return "---"
    end
  end

  def getPseudonym(asker)
    if (self.privacy.pseudonympriv == 2 or asker.Is_Admin)     #public
      if self.pseudonym != nil
        return self.pseudonym
      else
        return "Anonymous"
      end
    elsif (self.privacy.pseudonympriv == 1 and inCollaborators(asker))  #available to collaborators
      if self.pseudonym != nil
        return self.pseudonym
      else
        return "Anonymous"
      end
    elsif (asker == self)   #displaying for self
      if self.pseudonym != nil
        return self.pseudonym
      else
        return "Anonymous"
      end
    else
      return "Anonymous"
    end
  end

  def getRegion(asker)
    if (self.privacy.regionpriv == 2 or asker.Is_Admin)     #public
      return self.region
    elsif (self.privacy.regionpriv == 1 and inCollaborators(asker))  #available to collaborators
      return self.region
    elsif (asker == self)   #displaying for self
      return self.region
    else
      return "---"
    end
  end

  def getEmail(asker)
    if (self.privacy.emailpriv == 2 or asker.Is_Admin)     
      return self.email
    elsif (self.privacy.emailpriv == 1 and inCollaborators(asker))  
      return self.email
    elsif (asker == self)
      return self.email
    else
      return "---"
    end
  end

  def getPhone(asker)
    if (self.privacy.phonepriv == 2 or asker.Is_Admin)     
      return self.phone_number 
    elsif (self.privacy.phonepriv == 1 and inCollaborators(asker))  
      return self.phone_number
    elsif (asker == self)
      return self.phone_number
    else
      return "---"
    end
  end

  def getTwitter(asker)
    if (self.privacy.twitterpriv == 2 or asker.Is_Admin)
      return self.twitter
    elsif (self.privacy.twitterpriv == 1 and inCollaborators(asker))
      return self.twitter
    elsif (asker == self)
      return self.twitter
    else
      return "---"
    end
  end

  def inCollaborators(researcher)
    self.collaborators.each do |collab|
      if collab.collabid == researcher.id
        return true
      end
    end
    return false
  end
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def self.search(search, search_type)
    if (search)
      if (search_type == 'name')
        self.find(:all, :conditions => ['name LIKE ?', "#{search}"])
      elsif (search_type == 'expertise')
        self.find(:all, :conditions => ['expertise LIKE ?', "#{search}"])
      elsif (search_type == 'pseudonym')
        self.find(:all, :conditions => ['pseudonym LIKE ?', "#{search}"])
      elsif (search_type == 'region')
        self.find(:all, :conditions => ['region LIKE ?', "#{search}"])
      end
    else
      self.find(:all)
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.select_researchers_for_question(question, current_user)
return Researcher.where(:status => 1).where(:expertise => question.topic).order('RANDOM()').limit(3).all #TODO - Something smarter than this please
  end

    # This will be used by an algorithm to constantly change the rating of a researcher
    def UpdateRating(point)
        self.rating_n += 1
        self.rating = (self.rating + point) / self.rating_n
    end

end
