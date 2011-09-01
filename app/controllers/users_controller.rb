class UsersController < ApplicationController
  before_filter :find_user_with_deals, :only => :show
  # before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource :find_by => :username

  def show
  end

  def edit
  end

  #Lembrar de dar Reset Ability (CanCan)
  #def update
  #end

  def follow
    unless current_user.follow? @user
      current_user.follow! @user
      redirect_to user_path(@user.username), :notice => "Started following: '#{@user.username}'"
    else
      redirect_to user_path(@user.username), :alert => "You already follow: '#{@user.username}'"
    end
  end

  def unfollow
    if current_user.follow? @user
      current_user.unfollow! @user
      redirect_to user_path(@user.username), :notice => "Stopped following: '#{@user.username}'"
    else
      redirect_to user_path(@user.username), :alert => "You do not follow: '#{@user.username}'"
    end
  end

  private

  def find_user_with_deals
    #TODO: buscar também as deals dos usuários seguidos
    User.includes(:deals).where(:id => params[:id])
  end
end
