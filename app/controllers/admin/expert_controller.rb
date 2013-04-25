class Admin::ExpertController < Admin::BaseController
  def index
    @experts = Expert.all
  end

  def new
    @newExpert = Expert.new
  end
  
  def create
    @newExpert.topic = params[:topic]
    @newExpert.save
  end
  
  def activate
    @expert = Expert.find params[:id]
    @expert.update_attributes(:active => true)
    
    redirect_to [:admin, :expert]
  end

  def deactivate
    @expert = Expert.find params[:id]
    @expert.update_attributes(:active => false)
  
    redirect_to [:admin, :expert]
  end
end
