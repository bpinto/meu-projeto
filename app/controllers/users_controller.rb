class UsersController < ApplicationController
  before_filter :authenticate_user!

  def show
    @user = User.includes(:deals).find(params[:id])
  end

  def follow
    user = User.find params[:id]

    unless current_user.follow? user
      current_user.follow! user
      redirect_to user, :notice => "Started following: '#{user.email}'"
    else
      redirect_to user, :alert => "You already follow: '#{user.email}'"
    end
  end

  def unfollow
    user = User.find params[:id]

    if current_user.follow? user
      current_user.unfollow! user
      redirect_to user, :notice => "Stopped following: '#{user.email}'"
    else
      redirect_to user, :alert => "You do not follow: '#{user.email}'"
    end
  end
end
