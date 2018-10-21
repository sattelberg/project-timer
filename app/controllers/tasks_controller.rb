class TasksController < ApplicationController
  def show
    @task = Task.find(params[:id])
    render :show
  end
  def index
    @task = Task.all
    render :index
  end
  def edit
    @task = Task.find(params[:id])
    render :edit
  end
  def update
    task = Task.find(params[:id])
    tparam = params[:task]
    task.task_name = tparam[:task_name]
    task.project = Project.find(tparam[:project_id])
    task.user = User.find(tparam[:user_id])
    task.updated_at = DateTime.current.in_time_zone('UTC')
    if task.save
      flash[:notice] = "Sucessfully Updated"
      redirect_to task, status: 301
    else
      flash[:error] = "Error During Update"
      redirect_to edit_task_path(params[:id]), status: 301
    end
  end
  def new
    @task = Task.new
    render :new
  end
  def create
    task = Task.new
    tparam = params[:task]
    task.task_name = tparam[:task_name]
    task.project = Project.find(tparam[:project_id])
    task.user = User.find(tparam[:user_id])
    task.updated_at = DateTime.current.in_time_zone('UTC')
    task.created_at = task.updated_at
    if  task.save
      flash[:notice] = "Task Created"
      redirect_to task, status: 301
    else
      flash[:error] =  "Error: Create Failed"
      redirect_to new_task_url, status: 301
    end
  end
  def destroy
    if(Task.find(params[:id]).destroy)
      flash[:notice] =  'Successful Delete'
      redirect_to tasks_path,status: 301
    else
      flash[:notice] = 'Error: Delete Failed'
      redirect_to tasks_path,status: 301
    end
  end
end
