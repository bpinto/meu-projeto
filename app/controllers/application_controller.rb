#coding: UTF-8
class ApplicationController < ActionController::Base
  before_filter :go_to_facebook
  before_filter :fill_deals_lists, :delete_facebook_data

  protect_from_forgery

  def user_cities_ids
    #TODO: user_session está sempre preenchida?
    user_session ||= {}
    user_session[:cities_ids] ||= current_user.cities.collect(&:id) if current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def failure
    redirect_to root_path, :alert => "Não foi possível efetuar o login via facebook."
  end

  private

  def fill_deals_lists
    deals = Deal.active
    deals = deals.by_cities(user_cities_ids) if user_cities_ids.try(:any?)
    @best_deals = deals.voted.best_deals.limit(3)
    @newest_deals = deals.recent.limit(3)
    @most_comment_deals = deals.most_commented.limit(3)
  end

  def delete_facebook_data
    if session["devise.facebook_data"]
      session["devise.facebook_data"] = nil
    end
  end

#  def authenticate
#    return true unless Rails.env == "production"
#    authenticate_or_request_with_http_basic do |username, password|
#      username == "dealwitme" && password == "123dealwitme"
#    end
#  end

  def go_to_facebook
    redirect_to "https://www.facebook.com/OfertUs/app_151503908244383" #if Rails.env == "production"
  end

end
