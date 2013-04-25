require "watir-webdriver"
browser = Watir::Browser.new :ff


for i in 1..4 do
	browser.goto "174.119.253.250:3000/researchers/new"

	emails1 = ['t1@','t2@','t3@','t4@']
	emails2 = ['t1','t2','t3','t4']
	emails3 = ['.com','.net','.ca','.org']
	email = emails1[rand(4)]+emails2[rand(4)]+emails3[rand(4)] 

	researchers1 = ['john','mary','steve','peter']
	researchers2 = ['smith','jones','queen','kent']
	researchers3 = [' ','I','II','Jr.']
	researcher = researchers1[rand(4)]+researchers2[rand(4)]+researchers3[rand(4)] 

	mobiles1 = ['647','648','416','534']
	mobiles2 = ['645','339','712','533']
	mobiles3 = ['1998','1889','0987','0098']
	mobile = mobiles1[rand(4)]+mobiles2[rand(4)]+mobiles3[rand(4)] 
	 
	browser.text_field(:id => "researcher_name").set researcher
	browser.text_field(:id => "researcher_email").set email
	browser.text_field(:id => "researcher_mobile_number").set mobile

	browser.button(:name => "commit").click

	browser.goto "174.119.253.250:3000/admin/researchers#index"

	if (browser.text.include? researcher) and (browser.text.include? email) and (browser.text.include? mobile)
		puts "Test Passed"
	else
		puts "Test Failed"
	end
end
