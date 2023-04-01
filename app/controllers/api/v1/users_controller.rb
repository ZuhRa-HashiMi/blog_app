class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: %i[show]
  def index
    @users = User.all
    if @users
      render json: @users
    else
      render json: { error: 'Users not found' }
    end
  end

  def show
    if @user
      render json: @user
    else
      render json: { error: 'User not found' }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end
end
