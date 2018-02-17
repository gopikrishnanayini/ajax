class TasksController < ApplicationController
  before_action :find_task, :only => [:new, :create, :edit, :show, :update, :destroy]

  def index
    @incomplete_tasks = Task.where(:complete => false)
    @complete_tasks = Task.where(:complete => true)
  end

  def new
    @task = Task.new
  end
  
  def create
    @task = Task.new(task_params)
    if @task.save
	    respond_to do |format|
	   	  format.html {redirect_to tasks_url}
	   	  format.js
	    end
    else
      render "new"
	  end
  end
	def update
	  @task.update_attributes(task_params)
	  respond_to do |f|
	    f.html { redirect_to tasks_url }
	    f.js
	  end
	end

  def destroy
    @task = Task.destroy(params[:id])
    redirect_to tasks_url
  end

  private
  def find_task
    @task = Task.find_by_id(params[:id])
  end
  
  def task_params
    params.require(:task).permit!
  end
end
