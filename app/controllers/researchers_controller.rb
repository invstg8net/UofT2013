class ResearchersController < ApplicationController
  def new
    @researcher = Researcher.new
  end

  def create
    config.logger = Logger.new(STDOUT)
    @researcher = Researcher.new params[:researcher]
    @researcher.expertise = (params[:expertise])[:topic] 
    @researcher.setPrivacy
    if @researcher.save
      redirect_to root_url + "sessions/new", :notice => "Signed up!"
    else
      render "new"
    end
  end 

  def questions
    if current_user
      email = current_user.email
      @questions = Question.where("email = ?", email)
      ans = Answer.where("researcher_id = ?", Researcher.where("email = ?", email).first).pluck(:question_id)
      @aquestions = Question.where(:id => ans)
      @answers = Answer.all
    else
       redirect_to root_url
    end
  end
	
  def account
    if current_user
      email = current_user.email
      @researcher = Researcher.where("email = ?", email)

    else
      redirect_to root_url
    end
  end

  def edit
    if current_user
      email = current_user.email
      @researcher = Researcher.where("email = ?", email).first
    else
      redirect_to root_url
    end
  end

  def show
    if current_user
      email = current_user.email
      @researcher = Researcher.where("email = ?", email).first
      @privacy = @researcher.privacy
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @researcher }
      end
    else
      redirect_to root_url
    end
  end

# Add search page
  def search

  end

  def search_results

  end

  def collaborators

  end

# Testing
  def browse
    @researchers = Researcher.order('id ASC').all
    @experts = Expert.all
    @researchers.each do |r|
	    r.setPrivacy()
    end
  end

  def collaborators
    @collaborators = current_user.collaborators
  end

  def collaborate
    #add this user to collaborator table
    @newcollab = Collaborator.new :researcher_id => current_user.id, :collabid => params[:target_user_id]
    @newcollab.save
    #send a message to this user
    @newmessage = Message.new :sender => current_user.id, :researcher_id => params[:target_user_id], :message => "User #{current_user.id} has sent a collaboration request."
    @newmessage.save
    if current_user.Is_Admin
      redirect_to [:admin, :researchers]
    else
      redirect_to [:researchers, :browse]
    end
  end

  def uncollaborate
    collaborator = current_user.collaborators.where(:researcher_id => current_user.id, :collabid => params[:target_user_id]).first
    Collaborator.delete(collaborator.id)
    if params[:location] == "browse"
      if current_user.Is_Admin
        redirect_to [:admin, :researchers]
      else
        redirect_to [:researchers, :browse]
      end
    elsif params[:location] == "collaborators"
      redirect_to [:researchers, :collaborators]
    end
  end

  def update
    if current_user
      email = current_user.email
      @researcher = Researcher.where("email = ?", email).first
      @researcher.expertise = (params[:expertise])[:topic]
      respond_to do |format|
        if @researcher.update_attributes(params[:researcher])
          format.html { redirect_to @researcher, notice: 'Researcher was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @researcher.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_url
    end
  end
end
