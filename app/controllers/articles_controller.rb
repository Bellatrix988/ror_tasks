class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  http_basic_authenticate_with email: "orange",
                               password: "secret",
                               except: [:index, :show]
  def index
    @articles = Article.includes(:author, :tags).all

    if params[:tag].present?
      ids = Tag.find_by(name: params[:tag]).try(:articles).try(:ids)
      @articles = @articles.where(id: ids)
    end

    @articles = @articles.paginate(page: params[:page], per_page: 10)
                         .order(created_at: :DESC)
  end

  def show
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to @article
    else
      render 'new'
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :text)
  end

end
