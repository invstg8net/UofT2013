# -*- coding: utf-8 -*-
#require 'name'
#require 'expert'
#require 'rating'
#require 'maxquestion'
#require 'status'
#require 'maxquestion'
#require 'textcap.rb'

class Researcher < User
  has_many :answers
  has_many :questions
  set_table_name "researchers"
  attr_accessible :activated, :phone_number, :name, :Is_Admin
  attr_accessor :password
 
 # @researcher_name = new Name
 # @researcher_expertise = new Expert
 # @researcher_rating = new Rating
 # @researcher_pnumber = new Phone
 # @researcher_status = new Status
 # @researcher_maxquestion = new QuestionCap
 # @researcher_textlengthcap = new TextLengthCap
  before_save :encrypt_password
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :phone_number
  validates_uniqueness_of :email

#  def initialize (name, rating, expertise, phone_number, max_question, text_length_cap)  
#	@researcher_name.setName(name)
#  	@researcher_rating.setRating(rating)
#  	@researcher_expertise.setExpertise(expertise)
# 	@researcher_pnumber.setPhone(phone_number)
#	@researcher_maxquestion.setQuestionCap(max_question)
#	@researcher_maxquestion.setTextLengthCap(text_length_cap)
#	@researcher_status.setStatus(0);
#  end

end
