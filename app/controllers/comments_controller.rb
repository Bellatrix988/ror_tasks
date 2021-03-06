class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    redirect_to article_path(@article)
  end

  def show
  end

  private

    def comment_params
      params.require(:comment).permit(:user_name, :text)
    end

    def set_comment
      @comment = Comment.find(params[:id])
    end
end
