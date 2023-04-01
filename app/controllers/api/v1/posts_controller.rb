class Api::V1::PostsController < ApplicationController
  def index
    @posts = Post.all
    @user = User.find(params[:user_id])
    render json: @posts
  end

  def show
    @post = User.find(params[:user_id]).posts.find(params[:id])
    render json: @post
  end

  def create
    @post = Post.new(post_params)
    @post.comments_counter = 0
    @post.likes_counter = 0
    @post.user_id = current_user.id
    if @post.save
      render json: @post
    else
      render json: { error: 'Post not created.' }
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      render json: { message: 'Post deleted.' }
    else
      render json: { error: 'Post deletion failed.' }
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
