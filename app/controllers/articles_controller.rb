class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :authenticate_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 5)
  end

  def show; end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(permited_params)
    @article.user = current_user

    if @article.save
      flash[:notice] = 'Article was created successfully.'
      redirect_to @article
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def update
    if @article.update(permited_params)
      flash[:notice] = 'Article was updated successfully.'
      redirect_to @article
    else
      render 'edit', status: :unprocessable_entity
    end
  end

  def edit; end

  def destroy
    @article.destroy
    redirect_to articles_path
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def permited_params
    params.require(:article)
          .permit(:title, :description, category_ids: [])
  end

  def authenticate_user
    if @article.user != current_user && !current_user.admin?
      flash[:alert] = 'You are not authorized to perform that action'
      redirect_to @article
    end
  end
end
