class UsersController < AuthorizedController
  prepend_before_filter :find_user_with_deals, :only => :show

  def show
  end

  #Lembrar de dar Reset Ability (CanCan)
  #def update
  #end

  def follow
    unless current_user.follow? @user
      current_user.follow! @user
      redirect_to @user, :notice => "Started following: '#{@user.email}'"
    else
      redirect_to @user, :alert => "You already follow: '#{@user.email}'"
    end
  end

  def unfollow
    if current_user.follow? @user
      current_user.unfollow! @user
      redirect_to @user, :notice => "Stopped following: '#{@user.email}'"
    else
      redirect_to @user, :alert => "You do not follow: '#{@user.email}'"
    end
  end

  private

  def find_user_with_deals
    User.includes(:deals).where(:id => params[:id])
  end
end
