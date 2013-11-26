class AdminController < ApplicationController
  before_action :signed_in_user,
                only: [:index, :edit, :update, :destroy, :dashboard]
  before_action :admin_user,     only: :dashboard
  def dashboard
    @events = Event.all
    @events_time = Event.select('sum(end_time - start_time) as duration,user_id').group(:user_id)
    @events_project = Event.select('sum(end_time - start_time) as duration,project_id').group(:project_id)
  end

  def admin_user
    redirect_to(@current_user) unless current_user.admin?
  end
end