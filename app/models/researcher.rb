class Researcher < ActiveRecord::Base
  has_many :answers
  has_one :privacy
  has_many :collaborators
  has_many :messages

attr_accessible :email, :password, :password_confirmation, :status, :name, :region, :pseudonym, :phone_number, :mobile_number, :Is_Admin, :max_questions, :textcap, :rating, :rating_n

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
      #poor style, but set up collab table here too
      #if self.collaborators.nil?
       #   self.create_collaborators
      #end
      @namewrapper = Name.new
      @namewrapper.name = self.name
      @namewrapper.hidden = self.privacy.namepriv
      
      @emailwrapper = Email.new
      @emailwrapper.email = self.email
      @emailwrapper.hidden = self.privacy.emailpriv
      
      @phonewrapper = Phone.new
      @phonewrapper.phone = self.phone_number
      @phonewrapper.hidden = self.privacy.phonepriv
      
  end

  def getName(asker)
    return @namewrapper.getName(inCollaborators(asker))
  end

  def getEmail(asker)
    return @emailwrapper.getEmail(inCollaborators(asker))
  end

  def getPhone(asker)
    return @phonewrapper.getPhone(inCollaborators(asker))
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
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.select_researchers_for_question(question)
return Researcher.where(:status => 1).where(:expertise => question.topic).order('RANDOM()').limit(3).all #TODO - Something smarter than this please
  end

    # This will be used by an algorithm to constantly change the rating of a researcher
    def UpdateRating(point)
        self.rating_n += 1
        self.rating = (self.rating + point) / self.rating_n
    end

end
