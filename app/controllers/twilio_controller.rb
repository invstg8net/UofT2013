class Twilio3 < ActiveRecord::Base

	def new
    	@question = Question.new
  end

	def initialize
	# put your own credentials here
		account_sid = 'AC4bba3425e18cfd02baaba6276078513d'
		auth_token = '18dc610a87eb910067f434d05f3f7473'
		# set up a client to talk to the Twilio REST API
		@client = Twilio::REST::Client.new account_sid, auth_token
	end

	def send
	@client.account.sms.messages.create(
	  :from => '2898029128',
	  :to => '6477829567',
	  :body => 'Hey there!'
	)
	end

	def receive
	# Gets the whole log of messages from the account and displays it's contents
		@client.account.sms.messages.list.each do |message|
		@message = @client.account.sms.messages.get(message.sid)
		puts message.sid
		puts message.date_sent
		puts message.from
		puts message.to
		puts message.body
	  end
	end

	def create
		@client.account.sms.messages.list.each do |message|
		@message = @client.account.sms.messages.get(message.sid)
		puts message.sid
		puts message.date_sent
		puts message.from
		puts message.to
		puts message.body
	  q_params = params[:question] || params
		end
		
    #Create the question
    q = Question.new :body => message.body, :phone_number => 123456789, :email => message.from, :needed_by => q_params[:needed_by]
    q.needed_by ||= Time.now + 5.days
    q.save
	end
end
