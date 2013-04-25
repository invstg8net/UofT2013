class ExpertController < ApplicationController
	def new
		@expert = Expert.new
	end

	def create
		@expert = Expert.new
		@expert.researcher_count = 0
		@expert.active = false
	end

	def index
		@experts = Expert.all
		respond_to do |format|
			format.html
			format.json { render :json => @experts }
		end
	end
end
