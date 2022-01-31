class ApplicationController < ActionController::API
  include ExceptionHandler
  attr_reader :current_user

  before_action :authenticate_request

  private

  # Checks the header to see if user is allowed to make a request
  # Renders a 401 json response if not able, otherwise sets current user
  # and returns nothing.
  def authenticate_request
    @current_user = AuthorizeApiRequest.call(request.headers).result
    render json: { message: I18n.t('application.alert.not_authorized') }, status: :unauthorized unless @current_user
  end
end
