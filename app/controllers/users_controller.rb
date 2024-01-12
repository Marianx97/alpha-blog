class UsersController < ApplicationController
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

  private

  def permited_params
    params.require(:user).permit(:username, :email, :password)
  end
end
