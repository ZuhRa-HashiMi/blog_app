class CommentsController < ApplicationController
    def new
        @comment = Comment.new
    end

    def create
        @user = current_user
        @post = Post.find(params:[:post_id])
        @comment = @user.comments.new(post: @post, text: params[:text])
        if @comment.save
            redirect_to_user_posts_path(@user, @post)
        else
            render 'new'
        end
    end
end

