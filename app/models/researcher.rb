# -*- coding: utf-8 -*-
#require './name'
#require './expert'
#require './rating'
#require './maxquestion'
#require './status'
#require './textcap'

class Researcher < User
  has_many :answers
  has_many :questions
  set_table_name "researchers"
  attr_accessible :activated, :phone_number, :name, :Is_Admin
  attr_accessor :password
 
  @researcher_name = Name.new
  @researcher_expertise = Expert.new
  @researcher_rating = Rating.new
  @researcher_pnumber = Phone.new
  @researcher_status = Status.new
  @researcher_maxquestion = QuestionCap.new
  @researcher_textlengthcap = TextLengthCap.new
  before_save :encrypt_password
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_presence_of :phone_number
  validates_uniqueness_of :email

  # Update the researcher's rating
  def AddRating(point)
      @researcher_rating.UpdateRating point
  end

end
