# This module offers the ability to handle exceptions gracefully and
# send a json response back to the user with the error message and the
# appropriate error code.
module ExceptionHandler
  # provides the more graceful `included` method
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |_e|
      render json: { message: I18n.t('application.alert.not_found') }, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |_e|
      render json: { message: I18n.t('application.alert.not_processable') }, status: :unprocessable_entity
    end
  end
end
