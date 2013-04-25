require 'test_helper'
require "watir-webdriver"
browser = Watir::Browser.new :ff


for i in 1..4 do
	browser.goto "174.119.253.250:3000/questions/new"
	emails1 = ['t1@','t2@','t3@','t4@']
	emails2 = ['t1','t2','t3','t4']
	emails3 = ['.com','.net','.ca','.org']
	email = emails1[rand(4)]+emails2[rand(4)]+emails3[rand(4)] 
	questions1 = ['who ','what ','when ','where ']
	questions2 = ['is ','are ','were ','do ']
	questions3 = ['you?','she?','he?','it?']
	question = questions1[rand(4)]+questions2[rand(4)]+questions3[rand(4)] 

	browser.text_field(:id => "question_email").set email
	browser.select_list(:id => 'question_needed_by').select "Whenever"
	browser.text_field(:id => "question_body").set question
	browser.button(:name => "commit").click

	browser.goto "174.119.253.250:3000/admin/questions#index"

	if (browser.text.include? question) and (browser.text.include? email)
	puts "Test Passed"
	else
	puts "Test Failed"
	end
end


