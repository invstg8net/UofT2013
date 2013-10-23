# -*- coding: utf-8 -*-
class Researcher < ActiveRecord::Base
  has_many :answers
  has_many :questions

  attr_accessible :id, :email, :password, :password_confirmation, :activated, :name, :phone_number, :status, :max_questions, :rating, :privacy
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :phone_number
  validates_presence_of :User_rating
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

  def GetMaxQuestions
    return self.max_questions
  end

  def SetMaxQuestion(max)
    self.max_questions = max
  end
  
  def GetRating
    return self.rating
  end
  
  def SetRating(rating)
    self.rating = rating
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
