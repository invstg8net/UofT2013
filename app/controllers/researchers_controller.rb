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

# Testing
  def browse
    @researchers = Researcher.order('id ASC').all
    @experts = Expert.all
    @researchers.each do |r|
	r.setPrivacy()
    end
    @collaborators = current_user.collaborators
  end

  def collaborate
    #@newcollab = Collaborator.new :researcher_id => params[:current_user_id], :collab_id => :id, :confirmed => false
    #@newcollab = Collaborator.create(:researcher_id => params[:current_user_id], :collabid => 1, :confirmed => false)
    @newcollab = current_user.collaborators.create(:collabid => 2, :confirmed => false)
    #@newcollab = Collaborator.new
    #@newcollab.write_attribute(:researcher_id, 2)
    #@newcollab.confirmed = false
    #@newcollab.collab_id = 2
    #@newcollab.save
    # Check if the collaborator is saved to the database
    if @newcollab.valid?
    #if @newcollab.confirmed == false
      redirect_to root_url + "sessions/new", :notice => "Collaborated!"
    else
      #redirect_to root_url + "sessions/new", :notice => "Didn't collaborate!"
    end
    redirect_to [:researchers, :browse]
  end

  def uncollaborate
    Collaborator.show_all
    #collaborator = Collaborator.find_by_researcher_id_and_collab_id(params[:current_user_id], :id)
    collaborator = current_user.collaborators.where(:researcher_id => current_user.id, :collabid => :id).first
    Collaborator.delete(collaborator.id)
    redirect_to [:researchers, :browse]
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
