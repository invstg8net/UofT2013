# -*- coding: utf-8 -*-
class Researcher < ActiveRecord::Base
  has_many :answers
  has_many :questions

  attr_accessible :id, :email, :password, :password_confirmation, :activated, :name, :phone_number, :status, :max_questions, :user_rating, :privacy, :expertise
  
  attr_accessor :password, :expertise_visible, :hidden_expertise
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :phone_number
  validates_presence_of :user_rating
  validates_presence_of :id
  validates_uniqueness_of :email
  
  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def GetExpertise
    if (self.expertise_visible == false)       #removes the user's visible expertise and 
	      self.hidden_expertise = self.expertise # gives the user a hidden field that is not
        self.expertise = nil                   # accessible
    end
        return self.expertise
  end

  def SetExpertise(field)
    if (['News, Sciences, Politics, Weather'].include? field) # Check if the field provided
      	self.expertise = field				      # is a valid one	
    else						      # otherwise return error 
        puts "Field can only be News, Sciences, Politics, or Weather" # message
    end
  end

  def HideExpertise(hide)
    if (hide == true)			# Hide the user's expertise field
      	self.expertise_visible = false  # check if the user wants to make it visible
    elsif (hide == false)
      	self.expertise_visible = true	# Set back the users visibility and make
	      self.expertise = self.expertise_visible # the expertise field visible again
    else # return an error if they provided a wrong argument
	      puts "Invalid Argument : Expected true/false for visibility"
    end
  end

  def GetMaxQuestions
    return self.max_questions
  end

  def SetMaxQuestion(max)
    self.max_questions = max
  end
  
  def GetRating
    return self.user_rating
  end
  
  def SetRating(rating)
    self.user_rating = rating
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.select_researchers_for_question(question)
    return Researcher.where(:activated => true).order('RANDOM()').limit(3).all #TODO - Something smarter than this please
  end

end
