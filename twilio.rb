require 'rubygems' # not necessary with ruby 1.9 but included for completeness
require 'twilio-ruby'

ENV['RAILS_ENV'] = "development" # Set to your desired Rails environment name
require './config/environment.rb'

class Twilio3
  # each account has multiple states
  # 0's state = able to receive request
  # 1's state = topic
  # 2's state = security
  # 3's state = time
  # 4's state = region
  # 5's state = question
  # 6's state = tags, send thank you
  $account_info = [];
  $updates = [];
  $last_message = "";
  $message_logs = [];
  
	def initialize
	# put your own credentials here
		account_sid = 'AC4bba3425e18cfd02baaba6276078513d';
		auth_token = '18dc610a87eb910067f434d05f3f7473';
		# set up a client to talk to the Twilio REST API
		@client = Twilio::REST::Client.new account_sid, auth_token;
    $last_message = @client.account.sms.messages.list.last;
	end

  # Add a phone number to the list of phone numbers that we should monitor.
  def add_account(phoneNumber)
    # format of $account_info = [phoneNumber, state number, topic, email, time answer, question]
    $account_info.insert(0, [phoneNumber, 0, "", "", "", ""]);
  end

  # take out any special characters like ; or '
  def string_parse(stringIn)
    stringOut = stringIn.downcase
    stringOut = stringOut.gsub(";", "")
    stringOut = stringOut.gsub("'", "")
  end
  
  #not a very useful function, but will be kept in here for future use
	def get_message
		return @client.account.sms.messages.get("SM4c43cb130f7171b4e264b44eac950ca4");
	end

=begin
  # send an sms message with the body sendMessage, to the phone number sendTo
	def send(sendMessage, sendTo)
	@client.account.sms.messages.create(
	  :from => '2898029128',
	  :to => sendTo,
	  :body => sendMessage
	)
	end
=end

# send an sms message with the body sendMessage, to the phone number sendTo
# checks the length of the message to be sent, if length exceeds the user requested
# length, send
def send(sendMessage, sendTo)
    #---new code--- STILL NEEDS TO BE TESTED
    
    #get user to send to from database (edge case: what if not in db?)
    recepient = Researcher.find_by(phone_number: sendTo)
    
    message_length = sendMessage.length()
    
    #Each text has 145 characters
    number_texts = message_length/145
    
    #Message to be sent
    sent_message = nil
    
    #Checks the text capacity of the account
    if (number_texts > recepient.textcap)
        sent_message = "The number of texts that this message will send exceeds the number of your accounts capacity"
    	else
        sent_message = sendMessage
	end
    
    #original method
    @client.account.sms.messages.create(
                                        :from => '2898029128',
                                        :to => sendTo,
                                        :body => sent_message
                                        )
    
end

  # for testing purposes, print out all the messages in the twilio logs
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
  
  # get the first message in the twilio account
  def first_message
    return @client.account.sms.messages.list[0];
  end
  
  def service
  # see ReadMeForTAForSprint3Twilio.txt on how this works
    for new_message in $updates
      for account in $account_info
        if (account[0] == new_message.from)
          case account[1]
          when 0
            if (new_message.body == "$request")
              self.send("What is the topic of this request? \n", account[0]);
              account[1] = account[1] + 1;
            end
          when 1
            account[2] = new_message.body
            self.send("What is your email?", account[0]);
            account[1] = account[1] + 1;
          when 2
            account[3] = new_message.body
            self.send("What is the time of this request? \n1) < 6 hours($time 1)\n2) < 24 hours($time 2)\n3) < 3 days($time 3)\n4) < 1 week($time 4)\n5) Whenever($time 5)", account[0])
            account[1] = account[1] + 1
          when 3
            if (new_message.body == "$time 1" || new_message.body == "$time 2" || new_message.body == "$time 3" || new_message.body == "$time 4" || new_message.body == "$time 5")
              account[4] = new_message.body
              self.send("What is the question of this request?", account[0])
              account[1] = account[1] + 1
            end
          when 4
            account[5] = new_message.body
	    @question = Question.new
            @question.email = account[3]
	    @question.topic = account[2]
	    @question.phone_number = account[0]
	    @question.body = account[5]
	    @question.created_at = new_message.date_created
	    @question.updated_at = new_message.date_created
	    @question.needed_by = "2013-03-30 05:10:10"
	    @question.save
            researchers = Researcher.select_researchers_for_question(@question)
            researchers.each do |r|
              @question.send_to_researcher(r)
            end
            
            self.send("Thank you. Your request has been received.", account[0])
            account[1] = 0
          end
        end
      end
    end
  end
  
  def clear_updates
  # see ReadMeForTAForSprint3Twilio.txt on how this works
    for message in $updates
      $message_logs.insert(0, message.sid)
    end
    puts "CLEARED"
    $updates.clear
  end
  
  def print_updates
  # see ReadMeForTAForSprint3Twilio.txt on how this works
    for j in $updates
      puts j.body
    end
  end
  
  def updates
  # see ReadMeForTAForSprint3Twilio.txt on how this works
    temp_message = 0;
    @client.account.sms.messages.list.each do |message|
		@message = @client.account.sms.messages.get(message.sid);
    for account in $account_info
      if (message.sid == $last_message.sid)
        return nil;
      end
      if (!($message_logs.include?(message.sid)) && (message.sid != $last_message.sid) && (account[0] == message.from))
        puts "added one to updates"
        $updates.insert($updates.length, message)
        if (temp_message == 0)
          $last_message = message;
          temp_message = 1;
        end
      end
    #end
  end
  end
  end
end

temp = Twilio3.new

temp.add_account('+16477829567')

#message = temp.get_message
#puts temp.get_email(message.body)
#puts temp.get_body(message.body)
#puts temp.get_time(message.body)
#puts temp.get_risk(message.body)
i = 0
temp.updates
temp.print_updates
temp.clear_updates
while (i < 100000)
  temp.updates
  temp.print_updates
  if (i > 1)
    temp.service
  end
  temp.clear_updates
  puts i
  sleep 1
  i = i + 1
end
