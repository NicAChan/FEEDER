class SessionsController < ApplicationController
  def create
    @user = User.find_by_email params[:session][:email]

    if @user&.authenticate(session_params[:password])
        session[:user_id] = @user.id
        flash[:success] = "Signed in!"
        redirect_to teams_path

    else 
        flash.now[:danger] = "Incorrect Email or Password. Try again."
        render :new     
    end 
  end

  def destroy
    session[:user_id] =nil
    flash[:success] = "Signed out!"
    redirect_to root_path
  end

  private 
  def session_params 
      params.require(:session).permit(:email, :password)
  end 
end
