class PostsController < ApplicationController
  load_and_authorize_resource
  def index
    @posts = Post.all
    @user = User.find(params[:user_id])
  end

  def show
    @post = User.find(params[:user_id]).posts.find(params[:id])
  end

  def new
    @post = Post.new
    user_id = params[:user_id].to_i
    return if current_user.id == user_id
    authorize! :create, @post
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

  def destroy
    user = current_user
    @post = Post.find_by(id: params[:id], user_id: params[:user_id])
    @post.comments.destroy_all
    @post.likes.destroy_all
    if @post.destroy
      flash[:notice] = 'Post deleted '
    else
      flash[:alert] = 'post deletion failed'
    end
    redirect_to user_posts_path(user)
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
