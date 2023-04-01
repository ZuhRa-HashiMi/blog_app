class Api::V1::CommentsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    post = user.posts.find(params[:post_id])
    comments = post.comments
    render json: comments
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.destroy
      render json: { message: 'Comment deleted.' }
    else
      render json: { error: 'Comment not deleted.' }
    end
  end

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(post: @post, text: params[:text])
    if @comment.save
      render json: { message: 'Comment created.' }
    else
      render json: { error: 'Comment not created.' }
    end
  end
end
