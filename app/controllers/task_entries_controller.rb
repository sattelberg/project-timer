class TaskEntriesController < ApplicationController
  before_action :check_login
  def main
    @task = Task.all
    render :main
  end
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
    @te = TaskEntry.find(params[:id])
    if params[:task_entry][:task_id]
      @tparam = params[:task_entry]
      @te.task = Task.find(tparam[:task_id])
      @te.note = tparam[:note]
      @te.duration=tparam[:duration]
      @te.updated_at = DateTime.current.in_time_zone('UTC')
    elsif @te.start_time
      if @te.duration.nil?
        @te.duration = 0
      end
      @te.duration += ((DateTime.current - @te.start_time.to_datetime)*24*60*60).to_i
      @te.start_time = nil
    else
      @te.start_time = DateTime.current
    end
    if @te.save
      flash.now[:notice] = "Sucessfully Updated"
    else
      puts @te.errors.full_messages
      flash.now[:error] = "Error During Update"
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
=begin
      te.duration=(tparam["duration(4i)"] +':'+ tparam["duration(5i)"])
      te.start_time =  DateTime.new(tparam["start_time(1i)"].to_i, 
                        tparam["start_time(2i)"].to_i,
                        tparam["start_time(3i)"].to_i,
                        tparam["start_time(4i)"].to_i,
                        tparam["start_time(5i)"].to_i)
=end
      te.updated_at = DateTime.current.in_time_zone('UTC')
      te.created_at = te.updated_at
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
