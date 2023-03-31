class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end
  
  def destroy 
    @post = Post.find(params[:post_id])
    @comment =@post.comments.find(params[:id])
    @comment.destroy
    redirect_back(fallback_location: root_path)
    flash[:notice] = "Comment successfully deleted."
  end
  
  def create
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @user.comments.new(post: @post, text: params[:text])
    if @comment.save
      redirect_to user_posts_path(@user, @post)
    else
      render 'new'
    end
  end
end
