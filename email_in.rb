
require 'net/imap'



ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
require './config/environment.rb'

get = Researcher.where("name = ?", "superuser")



imap = Net::IMAP.new('imap.gmail.com', 993, true)
imap.login("invstg8net@gmail.com", "oswegatchie")
imap.select('INBOX')
imap.search(['ALL']).each do |message_id|
	msg = imap.fetch(message_id,'RFC822')[0].attr['RFC822']
	mail = Mail.read_from_string msg
		puts mail.subject
		puts mail.body


   
end



=begin
imap.search(["NOT", "SEEN"]).each do bla.bla.bla
=end





