module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound do |e|
      render json: e.message, status: :not_found
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      render json: e.message, status: :unprocessable_entity
    end
  end
end