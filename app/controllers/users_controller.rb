class UsersController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy]
  before_action :admin_user,     only: :destroy

  def index
    if !params[:user].nil?
      @users = User.where(user_id:params[:user][:user_id],:per_page => 5)
      respond_to do |format|
        format.html
        format.csv { render text: @users.to_csv }
        format.xls
      end
    else
      @users = User.order(:name).paginate(page: params[:page],:per_page => 5)
      respond_to do |format|
        format.html
        format.csv { render text: @users.to_csv }
        format.xls

      end
    end

  end
  def export
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="users.xls"'
    headers['Pragma'] = 'no-cache'
    headers['Expires'] = '0'
    @users = User.find(:all)

  end
  def show
    @user = User.find(params[:id])
    @events = Event.order("start_time ASC").where(user_id:@user.id)
  end
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to attendance"
      redirect_to @user
    else
      render 'new'
    end
  end
  def edit
    @user = User.find params[:id]
  end
  def update
      @user = User.find params[:id]
    respond_to do |format|
      if @user.update(user_params)
        @user.save
        format.html { redirect_to @user, notice: 'Employee was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end



  private

  def user_params
    params.require(:user).permit(:level,:name,:last, :email,:company,:address,:zip,:phone,:fax,:description, :password,
                                 :password_confirmation,:admin)
  end
  # Before filters
  def set_user
    @user = User.find(params[:id])
  end
  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_url, notice: "Please sign in."
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def admin_user
    redirect_to(root_url) unless current_user.admin?
  end
end