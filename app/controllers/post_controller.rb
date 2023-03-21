class PostController < ApplicationController
  def index
    @post = posts.find_by(author_id: params[:id])
  end

  def show 
    @user = posts.find_by(author_id: params[:id], :id params[:id])
  end
end
