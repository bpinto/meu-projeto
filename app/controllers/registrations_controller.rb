#coding: UTF-8
class RegistrationsController < Devise::RegistrationsController

  def create
    if not params[:terms_privacy]
      flash.now[:error] = "Para se cadastrar é necessário concordar com os termos de uso e a política de privacidade do site."
      build_resource
      clean_up_passwords(resource)
      respond_with_navigational(resource) { render_with_scope :new }
    else
      super
    end
  end
end