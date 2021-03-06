class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include SessionsHelper
  include FormatHelper

  def authorize
    unless logged_in?
      redirect_to root_path
    end
  end
end
