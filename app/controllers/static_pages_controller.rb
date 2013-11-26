class StaticPagesController < ApplicationController
  def home
   #if signed_in?
      @events = Event.all
      @events_time = Event.select("id,start_time,end_time,user_id").order("user_id")
   #end
      if params[:texto] != ""
          p = "%#{params[:texto]}%"
          @users = User.where("name LIKE ? OR email LIKE ? ",p,p).paginate(page: params[:page],:per_page => 5)
     else
          p = "#{params[:texto]}"
          @users = User.where("name LIKE ? OR email LIKE ? ",p,p).paginate(page: params[:page],:per_page => 5)
      end
  end


  def help
  end

  def about
  end

  def _contact

  end
end