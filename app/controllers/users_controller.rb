# coding: UTF-8
class UsersController < ApplicationController
  before_filter :find_user_with_deals, :only => :show
  before_filter :store_location, :only => [:index, :show]
  prepend_before_filter :find_users, :only => :index
  # before_filter :authenticate_user!

  check_authorization
  load_and_authorize_resource :find_by => :username

  def show
    @title = @user.username
  end

  def index
    flash.now[:notice] = "Não foi encontrado nenhum usuário" if @users.empty? && params[:search]
    @title = "Buscar Usuários"
  end

  #Lembrar de dar Reset Ability (CanCan)
  #def update
  #end

  def follow
    unless current_user.follow? @user
      current_user.follow! @user
      if current_user.provider? && current_user.facebook_follow_user
        me = FbGraph::User.me(current_user.access_token)
        me.feed!(:message => current_user.name + " está seguindo as ofertas de " + @user.name + " no DealWit.Me", :link => user_url(@user))
      end
      redirect_to stored_location, :notice => I18n.t('models.user.started_following', :username => @user.username)
      #redirect_to user_path(@user.username), :notice => I18n.t('models.user.started_following', :username => @user.username)
    else
      redirect_to stored_location, :alert => I18n.t('models.user.already_following', :username => @user.username)
      #redirect_to user_path(@user.username), :alert => I18n.t('models.user.already_following', :username => @user.username)
    end
    clear_stored_location
  end

  def unfollow
    if current_user.follow? @user
      current_user.unfollow! @user
      redirect_to stored_location, :notice => I18n.t('models.user.stopped_following', :username => @user.username)
      #redirect_to user_path(@user.username), :notice => I18n.t('models.user.stopped_following', :username => @user.username)
    else
      redirect_to stored_location, :alert => I18n.t('models.user.not_following', :username => @user.username)
      #redirect_to user_path(@user.username), :alert => I18n.t('models.user.not_following', :username => @user.username)
    end
    clear_stored_location
  end

  private

  def find_user_with_deals
    @deals = Deal.by_username_and_following(params[:id])
  end

  def find_users
    @users = User.paginate(:page => params[:page])
    @users = @users.search(params[:search].gsub(" ", "%")) if params[:search]
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def stored_location
    session[:return_to]
  end

  def clear_stored_location
    session[:return_to] = nil
  end

end
