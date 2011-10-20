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
      redirect_to user_path(@user.username), :notice => I18n.t('models.user.started_following', :username => @user.username)
    else
      redirect_to user_path(@user.username), :alert => I18n.t('models.user.already_following', :username => @user.username)
    end
  end

  def unfollow
    if current_user.follow? @user
      current_user.unfollow! @user
      redirect_to user_path(@user.username), :notice => I18n.t('models.user.stopped_following', :username => @user.username)
    else
      redirect_to user_path(@user.username), :alert => I18n.t('models.user.not_following', :username => @user.username)
    end
  end

  private

  def find_user_with_deals
    @deals = Deal.by_username_and_following(params[:id])
  end
end
