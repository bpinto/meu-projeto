class ApplicationController < ActionController::Base
#  before_filter :authenticate
  before_filter :fill_deals_lists

  protect_from_forgery

  def user_cities_ids
    #TODO: user_session está sempre preenchida?
    user_session ||= {}
    user_session[:cities_ids] ||= current_user.cities.collect(&:id) if current_user
  end

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  private

  def fill_deals_lists
    deals = Deal.active
    deals = deals.by_cities(user_cities_ids) if user_cities_ids.try(:any?)
    @best_deals = deals.voted.best_deals.limit(3)
    @newest_deals = deals.recent.limit(3)
    @most_comment_deals = deals.most_commented.limit(3)
  end

#  def authenticate
#    return true unless Rails.env == "production"
#    authenticate_or_request_with_http_basic do |username, password|
#      username == "dealwitme" && password == "123dealwitme"
#    end
#  end
end
