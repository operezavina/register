class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      sign_in user
      x = DateTime.now
      @event = Event.order("created_at ASC").where(user_id:user.id).last
      if @event != nil
        if @event.start_time.strftime("%F") != DateTime.now.strftime("%F")
           @event = Event.new(user_id:user.id,start_time:DateTime.new(x.year, x.month, x.day, x.hour, x.min,x.sec),name:user.email)
           @event.save
        end
        redirect_back_or user
      else
      @event = Event.new(user_id:user.id,start_time:DateTime.new(x.year, x.month, x.day, x.hour, x.min,x.sec),name:user.email)
      @event.save
      redirect_back_or user
      end
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def endday
    x = DateTime.now
    if session[:user_id]!= nil
      @event = Event.order("created_at ASC").where(user_id:User.find(session[:user_id])[:id]).last
      if  @event.start_time.strftime("%F") == DateTime.now.strftime("%F")
        @event.update_attributes(end_time:DateTime.new(x.year, x.month, x.day, x.hour, x.min,x.sec))
        @event.update_attributes(name:User.find(session[:user_id])[:name]+' start '+@event.start_time.strftime("%T")+' end '+x.strftime("%T"))
        @event.save
      end
    end
    reset_session
    sign_out
    redirect_to root_url
  end
  def destroy
    sign_out
    redirect_to root_url
    reset_session
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,:admin)
  end
end
