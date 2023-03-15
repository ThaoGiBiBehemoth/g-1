class TasksController < ApplicationController
  before_action :authorize
  before_action :set_task, only: %i[show update destroy]

  # LIST TASKS (GET: /tasks)
  def index
    # @tasks = @user.tasks.all
    # @tasks = @user.tasks.all.limit(params[:limit]).offset(params[:offset]) # chỉ phân trang
    @tasks = @user.tasks.ransack(params[:q]).result.limit(params[:limit]).offset(params[:offset]) # phân trang & search
    render json: @tasks
  end

  # SHOW EACH TASKS (GET: /tasks/1)
  def show
    render json: @task
  end

  # NEW TASK (POST: /tasks)
  def create
    @task = Task.new(task_params.merge(user: @user))

    if @task.save
      render json: @task, status: 200, location: @task # location: @task  : ???
    else
      render json: @task.errors, status: 422
    end
  end

  # UPDATE (PATCH/PUT: /tasks/1)
  def update
    if @task.update(task_params)
      render json: @task, status: 200
    else
      render json: @task.errors, status: 422
    end
  end

  # DELETE (DELETE: /tasks/1)
  def destroy
    if @task.destroy
      render json: { message: 'Delete successful.' }, status: 200
    else
      render json: @task.errors, status: 422
    end
  end

  private

  def set_task
    @task = @user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :descrip, :done, :deadline)
  end
end
