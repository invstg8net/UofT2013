class ResearchersController < ApplicationController
  def new
    @researcher = Researcher.new
  end

  def create
    config.logger = Logger.new(STDOUT)
    @researcher = Researcher.new params[:researcher]
    @researcher.setPrivacy
    @researcher.activated = false
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

      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @researcher }
      end
    else
      redirect_to root_url
    end
  end

# Testing
  def browse

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
