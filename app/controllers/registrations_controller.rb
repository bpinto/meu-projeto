#coding: UTF-8
class RegistrationsController < Devise::RegistrationsController

  def create
    if not params[:terms_privacy]
      flash.now[:error] = "Para se cadastrar é necessário concordar com os termos de uso e a política de privacidade do site."
      render 'new'
    else
      super
    end
  end
end