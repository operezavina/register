class ProjectsController < ActionController::Base
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :admin_user,     only: [:destroy,:index]
  def index
    @projects = Project.paginate(page:params[:page])
  end
  def new
   @project = Project.new
  end
  def edit

  end
  def show
  end
  def create
    @project = Project.new(project_params)
    respond_to do |format|
      if @project.save
        format.html { redirect_to projects_path, notice: 'Project was successfully created.' }
        format.json { render action: 'show', status: :created, location: @project }
      else
        format.html { render action: 'new' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end


  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url }
      format.json { head :no_content }
    end
  end

  private
  def set_project
    @project = Project.find(params[:id])
  end
  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    params.require(:project).permit(:name,:completed)
  end
  def current_user
    remember_token = User.encrypt(cookies[:remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end
  def admin_user
    redirect_to(@current_user) unless current_user.admin?
  end
end