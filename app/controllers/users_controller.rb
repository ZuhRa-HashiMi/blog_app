class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = Post.where(author_id: @user.id).order(created_at: :desc)
  end
end
