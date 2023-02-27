class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :login_required

  def login_required
    redirect_to new_session_path unless current_user
  end

  # before_action :basic_auth

  # private

  # def basic_auth
  #   authenticate_or_request_with_http_basic do |username, password|
  #     username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"]  # この1行を変更
  #   end
  # end
end