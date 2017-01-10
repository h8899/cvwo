class TasksController < ApplicationController 
	def index
		@q = Task.ransack(params[:q])
		@tasks = @q.result(distinct: true)
		@tasks.each do|task|
			day = Time.now - Time.parse(task.title)
			# I send email to remind one hour before the task
			if  (((day / 3600).to_f >= -1) && ((day / 3600).to_f < 0)) 
				ExampleMailer.sample_email(task).deliver
			end
			task.title = Time.parse(task.title)
		end
		@tasks = @tasks.sort_by { |a| [a.completed ? 1 : 0, a.title] }
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

		respond_to do |format|		
			if @task.save
				flash[:success] = 'Task was successfully created.'
				format.html { redirect_to @task }
				format.json { render :show, status: :created, location: @task }
			else
				flash[:danger] = 'There was a problem creating the task.'
				format.html { render :new }
				format.json { render json: @task.errors, status: :unprocessable_entity }
			end
		end
	end
 
	def update
		@task = Task.find(params[:id])
		respond_to do |format|
			if @task.update(task_params)
				flash[:success] = 'Todo was successfully updated.'
				format.html { redirect_to @task}
				format.json { render :show, status: :ok, location: @task }
			else
				flash[:danger] = 'There was a problem updating the Todo.'
				format.html { render :edit }
				format.json { render json: @task.errors, status: :unprocessable_entity }
			end
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
