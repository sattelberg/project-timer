class TaskEntriesController < ApplicationController
  before_action :check_login
  def show
    @te = TaskEntry.find(params[:id])
    render :show
  end
  def index
    @te = TaskEntry.all
    render :index
  end
  def edit
    @te = TaskEntry.find(params[:id])
    render :edit
  end
  def update
    te = TaskEntry.find(params[:id])
    tparam = params[:task_entry]
    te.task = Task.find(tparam[:task_id])
    te.note = tparam[:note]
    te.duration=tparam[:duration]
    te.updated_at = DateTime.current.in_time_zone('UTC')
    if te.save
      flash[:notice] = "Sucessfully Updated"
      redirect_to te, status: 301
    else
      flash[:error] = "Error During Update"
      redirect_to edit_task_entry_path(params[:id]), status: 301
    end
  end
  def new
    @te = TaskEntry.new
    render :new
  end
  def create
    te = TaskEntry.new
    tparam = params[:task_entry]
    te.task = Task.find(tparam[:task_id])
    te.note = tparam[:note]
    te.duration=(tparam["duration(4i)"] +':'+ tparam["duration(5i)"])
    te.start_time =  DateTime.new(tparam["start_time(1i)"].to_i, 
                        tparam["start_time(2i)"].to_i,
                        tparam["start_time(3i)"].to_i,
                        tparam["start_time(4i)"].to_i,
                        tparam["start_time(5i)"].to_i)
    te.updated_at = DateTime.current.in_time_zone('UTC')
    if  te.save
      flash[:notice] = "TaskEntry Created"
      redirect_to te, status: 301
    else
      flash[:error] =  te.errors
      redirect_to new_task_entry_url, status: 301
    end
  end
  def destroy
    if(TaskEntry.find(params[:id]).destroy)
      flash[:notice] =  'Successful Delete'
      redirect_to task_entries_path,status: 301
    else
      flash[:notice] = 'Error: Delete Failed'
      redirect_to task_entries_path,status: 301
    end
  end
end
