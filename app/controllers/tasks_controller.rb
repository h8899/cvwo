class TasksController < ApplicationController 
  def index
	@q = Task.ransack(params[:q])
	@tasks = @q.result(distinct: true)
	@tasks.each do|task|
		task.title = Date.parse(task.title)
	end
	@tasks = @tasks.sort { |a,b| b[:title] <=> a[:title] }
  end

  def complete
   @task = Task.find(params[:id])
   @task.completed = true
   @task.save
   redirect_to tasks_path
  end
	
  def show
    @task = Task.find(params[:id])
  end
 
  def edit
     @task = Task.find(params[:id])
  end
  
  def new
	@task = Task.new
  end
 
  def create
	@task = Task.new(task_params)
	@task.completed = false
	if @task.save
		redirect_to @task
	else
		render 'new'
  end
end
 
def update
  @task = Task.find(params[:id])
 
  if @task.update(task_params)
    redirect_to @task
  else
    render 'edit'
  end
end
 
 def destroy
  @task = Task.find(params[:id])
  @task.destroy
 
  redirect_to tasks_path
end


private
  def task_params
    params.require(:task).permit(:title, :text, :tag_list)
  end
end
