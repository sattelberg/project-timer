class ProjectsController < ApplicationController
  before_action :check_login
  def show
    @proj = Project.find(params[:id])
    render :show
  end
  def index
    @proj = Project.all
    render :index
  end
  def edit
    @proj = Project.find(params[:id])
    render :edit
  end
  def update
    proj = Project.find(params[:id])
    pparam = params[:project]
    proj.project_name = pparam[:project_name]
    proj.customer = Customer.find(pparam[:customer_id])
    proj.updated_at = DateTime.current.in_time_zone('UTC')
    if proj.save
      flash[:notice] = "Sucessfully Updated"
      redirect_to proj, status: 301
    else
      flash[:error] = "Error During Update"
      redirect_to edit_project_path(params[:id]), status: 301
    end
  end
  def new
    @proj = Project.new
    render :new
  end
  def create
    proj = Project.new
    pparam = params[:project]
    proj.project_name = pparam[:project_name]
    proj.customer = Customer.find(pparam[:customer_id])
    proj.updated_at = DateTime.current.in_time_zone('UTC')
    proj.created_at = proj.updated_at
    if  proj.save
      flash[:notice] = "Project Created"
      redirect_to proj, status: 301
    else
      flash[:error] =  "Error: Create Failed"
      redirect_to new_projomer_url, status: 301
    end
  end
  def destroy
    if(Project.find(params[:id]).destroy)
      flash[:notice] =  'Successful Delete'
      redirect_to projects_path,status: 301
    else
      flash[:notice] = 'Error: Delete Failed'
      redirect_to projects_path,status: 301
    end
  end
end
