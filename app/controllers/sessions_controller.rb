class SessionsController < ApplicationController

  def create
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      # if user.usertype == "student"
      #   redirect_to dashboard_path, notice: "Welcome to Catalyst #{user.first_name}!"
      # else
      redirect_to lessons_path#, notice: "Welcome to Catalyst, #{user.first_name}!"
    else
      redirect_to welcome_path, notice: "Something is wrong with your username and/or password. Please try again!"
    end
  end


  def delete

    session.delete :user_id # session[:username] = nil (should also work)
    redirect_to welcome_path, notice: "See you soon!"

  end

end
