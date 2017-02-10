class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]
  before_action :logged_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:show, :edit, :update]

  def show
    @microposts = @user.microposts.order("created_at DESC").paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to user_path(@user)
    else
      render 'new'
    end

  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash.now[:success] = "Your account is updated."
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page])
  end


  private

    def user_params
      params.require(:user).permit(:name, :email,
                                   :password, :password_confirmation, :avatar)
    end

    def find_user
      @user = User.find_by(id: params[:id])
    end



    def correct_user
      @user = User.find(params[:id])
      redirect_to root_path unless current_user?(@user)
    end


end
