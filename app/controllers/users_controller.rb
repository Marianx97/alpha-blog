class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def show
    @articles = @user.articles
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(permited_params)

    if @user.save
      flash[:notice] = 'Successfully signed up'
      redirect_to articles_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if @user.update(permited_params)
      flash[:notice] = 'User was updated successfully.'
      redirect_to articles_path
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
