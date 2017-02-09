class PasswordResetsController < ApplicationController
before_action :find_user, only: [:edit, :update]
before_action :valid_user, only: [:edit, :update]
before_action :check_expiration, only: [:edit, :update]
  def new
  end

  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with reset password instructions."
      redirect_to root_path
    else
      flash[:danger] = "Email invalid"
      render 'new'
    end
  end

  def edit
  end

  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "can't be empty!")
    elsif @user.update_attributes(user_params)
       log_in(@user)
       flash.now[:success] = "Password updated!"
       redirect_to new_password_reset_path
    else
      render 'edit'
    end
  end

  private

    def find_user
      @user = User.find_by(id: params[:id])
    end

    def valid_user
      unless (@user && @user.authenticated?(:reset, params[:id]))
        redirect_to root_path
      end
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def check_expiration
      if @user.password_reset_expired?
        flash.now[:danger] = "Password reset has been expired"
        redirect_to root_path
      end
    end

end
