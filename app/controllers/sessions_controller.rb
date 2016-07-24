class SessionsController < ApplicationController

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to dashboard_path, notice: "Welcome to VacationPics @#{user.username}!"
    else
      redirect_to welcome_path, notice: "Something is wrong with your username and/or password. Please try again, you can do it!!"
    end
  end


  def delete

    session.delete :user_id # session[:username] = nil (should also work)
    redirect_to welcome_path, notice: "Thanks! Come back later to share more vacation memories!"

  end

end
