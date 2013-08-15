class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.confirm_email(@user).deliver
      redirect_to photos_path
    else
      render action: :new
    end
  end


  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end
