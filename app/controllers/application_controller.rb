class ApplicationController < ActionController::Base
    protect_from_forgery
    include SessionsHelper

    before_filter :atualizar_cookie

end