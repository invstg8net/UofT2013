class PrivaciesController < ApplicationController

  def edit
    if current_user
      email = current_user.email
      @researcher = Researcher.where("email = ?", email).first
	  @privacy = @researcher.privacy
    else
      redirect_to root_url
    end
  end

	def update
    	if current_user
			email = current_user.email
			@researcher = Researcher.where("email = ?", email).first
			@privacy = @researcher.privacy
			respond_to do |format|
        		if @privacy.update_attributes(params[:privacy])
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
