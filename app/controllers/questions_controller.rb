class QuestionsController < ApplicationController
  def new
    @question = Question.new
    @experts = Expert.new
  end
  
  def edit
      if current_user
          @question = Question.find params[:id]
          else
          redirect_to root_url
      end
  end

  def update
    if current_user
      @question = Question.find params[:id]
      @question.body = params[:body]
      @question.save
      #if @qustion.body.nil?
        #Check to see if admin should be notified if all answers
        # puts "ESCALATE"
        # @answer.question.escalate_to_admin if @answer.question.should_escalate?
      #else
        #puts "SEND TO JORUNALIST"
        ##Email/SMS user who submitted the question
        #@answer.send_to_journalist
      #end
      render :thank_you
    else
       redirect_to root_url
    end  
  end


  def create
    q_params = params[:question] || params

    #Create the question
    if current_user
      q = Question.new :body => q_params[:body], :phone_number => Researcher.where("email = ?", current_user.email).first.phone_number, :email => current_user.email, :needed_by => q_params[:needed_by]
      q.needed_by ||= Time.now + 5.days
      q.topic = (params[:expertise])[:topic]
      #q.researcher_id
      q.save
#, :risk_level => q_params[:risk_level], :region => q_params[:region]

        #Choose X Random Researchers
      researchers = Researcher.select_researchers_for_question(q, current_user)

        #Email Random Researchers & Create Questions
      researchers.each do |r|
        q.send_to_researcher(r)
      end
    render :thank_you
    else
      q = Question.new :body => q_params[:body], :phone_number => q_params[:phone_number], :email => q_params[:email], :needed_by => q_params[:needed_by]
      @researcher = Researcher.new :phone_number => q_params[:phone_number], :email => q_params[:email], :password => q_params[:phone_number]
      @researcher.status = 0
      if @researcher.save
        q.needed_by ||= Time.now + 5.days
        q.topic = (params[:expertise])[:topic]
        q.save
#, :risk_level => q_params[:risk_level], :region => q_params[:region]

        #Choose X Random Researchers
        researchers = Researcher.select_researchers_for_question(q, current_user)

        #Email Random Researchers & Create Questions
        researchers.each do |r|
          q.send_to_researcher(r)
        end
        #q.send_to_researcher(Researcher.where("email = ?", current_user.email).first)
        redirect_to root_url+"sessions/new", :notice => "A new account was created for you on Invstg8.net and your question was submited to approval!. Your login is your email. Your password is your phone number (Change it later!). "
      else
        redirect_to root_url+"questions", :alert => "Error: You have to provide a valid email and phone number, so we can submit your question and create a new account on Invstg8.net for you. This email might already be taken!!"
      end
    end
    
  end

  def show
    if current_user
      @question = Question.find params[:id]
    else
       redirect_to root_url
    end
  end

end
