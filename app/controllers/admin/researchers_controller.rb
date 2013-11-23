class Admin::ResearchersController < Admin::BaseController

  def search

  end

  def index
    @researchers = Researcher.order('id ASC').all
    @experts = Expert.all
  end

  def activate
    @researcher = Researcher.find params[:id]
    @researcher.update_attributes(:status => 1)

    redirect_to [:admin, :researchers]
  end

  def deactivate
    @researcher = Researcher.find params[:id]
    @researcher.update_attributes(:status => 0)

    redirect_to [:admin, :researchers]
  end

  def ban
    @researcher = Researcher.find params[:id]
    @researcher.update_attributes(:status => -1)

    redirect_to [:admin, :researchers]
  end
  
  def activate_admin
    @researcher = Researcher.find params[:id]
    @researcher.update_attributes(:Is_Admin => true)

    redirect_to [:admin, :researchers]
  end
  def deactivate_admin
    @researcher = Researcher.find params[:id]
    @researcher.update_attributes(:Is_Admin => false)

    redirect_to [:admin, :researchers]
  end
end
