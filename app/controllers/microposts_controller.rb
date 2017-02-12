class MicropostsController < ApplicationController
before_action :find_micropost, only: [:show, :edit, :update, :destroy]
before_action :logged_in_user, only: [:create, :destroy]


  def show
    @microposts = Micropost.order("created_at DESC").take(6)
  end

  def index
    if params[:category].blank?
      @microposts = Micropost.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @microposts = Micropost.where(:category_id => @category_id).order("created_at DESC")
    end
  end

  def new
    @micropost = current_user.microposts.build
    @categories = Category.all.map { |c| [c.name, c.id] }
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    @micropost.category_id = params[:category_id]

    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = "Micropost isn't created!!!"
      render 'new'
    end
  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id] }
  end

  def update
    if @micropost.update_attributes(micropost_params)
      flash[:success] = "Micropost updated!"
      redirect_to micropost_path(@micropost)
    else
      render 'edit'
    end
  end

  def destroy
    @micropost.destroy
    redirect_to user_path(current_user)
  end

  def search
    @microposts = Micropost.search(params[:search]).order("created_at DESC")
  end

  private

    def micropost_params
      params.require(:micropost).permit(:name, :picture, :category_id)
    end

    def find_micropost
      @micropost = Micropost.find(params[:id])
    end

end
