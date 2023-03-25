class UsersController < ApplicationController
  def index
    @user = User.all
  end

  def show
    @user = User.find(params[:id])
    @post = Post.where(author_id: @user.id).order(created_at: :desc)
  end
end
