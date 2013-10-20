# -*- coding: utf-8 -*-
class Researcher < ActiveRecord::Base
  has_many :answers

  attr_accessible :email, :password, :password_confirmation, :activated, :name, :phone_number, :mobile_number, :Is_Admin, :Max_Questions
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :phone_number
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
    return self.Max_Questions
  end

  def SetMaxQuestion(max)
    self.Max_Questions = max
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
