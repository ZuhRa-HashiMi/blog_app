class PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.find(params[:user_id])
  end

  def show
    # @user = User.find(params[:author_id])
    # @post = Post.find_by(id:params[:id])
    @post = User.find(params[:user_id]).posts.find(params[:id])
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    @post = Post.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    @post.user_id = current_user.id
    if @post.save
      redirect_to user_posts_path(current_user, @post)
    else
      render 'new'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
