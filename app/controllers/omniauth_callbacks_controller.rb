#coding: UTF-8
class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    @user = User.find_for_facebook_oauth(request.env["omniauth.auth"], current_user)

    if @user
      #TODO: Ver internacionalizacao, colocar a traducao para funcionar
      #flash[:notice] = I18n.t "devise.omniauth_callbacks.login", :kind => "Facebook"
      flash[:notice] = "Login efetuado com sucesso."
      sign_in_and_redirect @user
    else
      data = request.env["omniauth.auth"]
      #user = User.apply_omniauth(data)
      #if user.save
        #TODO: Ver internacionalizacao, colocar a traducao para funcionar
        #flash[:notice] = I18n.t "devise.omniauth_callbacks.create"
        flash[:notice] = "Confira seus dados e clique em confirmar."
      #else
        session["devise.facebook_data"] = data
      #  flash[:alert] = I18n.t "devise.omniauth_callbacks.errors"
        redirect_to new_user_registration_url
      #end
    end
  end
end