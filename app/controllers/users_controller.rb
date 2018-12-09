class UsersController < ApplicationController
  before_action :find_user

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Thank you for signing up!"
      redirect_to teams_path
    else
      render :new
    end
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
        format.json { respond_with_bip(@user) }
      else
        format.html { render :action => "edit" }
        format.json { respond_with_bip(@user) }
      end
    end
  end

  # def destroy
  #   @user.destroy
  #   flash[:success] = "CYA NERD"
  #   redirect_to root_path
  # end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def find_user
    @user = current_user
  end
end