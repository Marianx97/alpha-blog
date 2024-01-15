class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(permited_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = 'Successfully signed up'
      redirect_to articles_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if @user.update(permited_params)
      flash[:notice] = 'User was updated successfully.'
      redirect_to @user
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def edit; end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def permited_params
    params.require(:user).permit(:username, :email, :password)
  end
end
