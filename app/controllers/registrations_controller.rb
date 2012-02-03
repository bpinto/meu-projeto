#coding: UTF-8
class RegistrationsController < Devise::RegistrationsController
  skip_before_filter :delete_facebook_data, :only => [:new, :create]

  def create
    if not params[:terms_privacy]
      flash.now[:error] = "Para se cadastrar é necessário concordar com os termos de uso e a política de privacidade do site."
      build_resource
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render :new }
    else
      super
    end
  end

  private
  
  def build_resource(*args)
    super
    if session["devise.facebook_data"]
      @user = User.apply_omniauth(session["devise.facebook_data"])
      if params[:user]
        @user.name = params[:user][:name]
        @user.email = params[:user][:email]
        @user.username = params[:user][:username]
        @user.confirmed_at = Date.today
      end
      @user.valid?
    end
  end
end