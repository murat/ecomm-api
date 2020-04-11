# frozen_string_literal: true
module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :internal_server_error
    rescue_from ActiveRecord::StatementInvalid, with: :bad_request
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity
    rescue_from PG::UniqueViolation, with: :not_acceptable
    rescue_from PG::ForeignKeyViolation, with: :not_acceptable
  end

  private

  def internal_server_error(exception)
    log_error(exception)
    render_error({ params[:controller].to_s.freeze => [exception.message] }, 500) && return
  end

  def not_found(exception)
    log_error(exception)
    render_error({ params[:controller].to_s.freeze => [exception.message] }, 404) && return
  end

  def bad_request(exception)
    log_error(exception)
    render_error({ params[:controller].to_s.freeze => [exception.message] }, 400) && return
  end

  def unprocessable_entity(exception)
    log_error(exception)
    render_error(exception.record.errors, 422) && return
  end

  def not_acceptable(exception)
    log_error(exception)
    render_error(exception.message, 406) && return
  end

  def render_error(errors, status)
    status_text = Rack::Utils::HTTP_STATUS_CODES[status].downcase.gsub(/\s+/, '_')

    render json: { errors: errors }, status: status_text.to_sym
  end

  def log_error(exception)
    # logger.error exception.message
    # logger.error exception.backtrace.join("\n")

    backtrace_size = exception.backtrace.size
    if backtrace_size >= 2 then max_range = 2
    elsif backtrace_size >= 1 then max_range = 1
    end
    if max_range.positive?
      s = "#{exception.message} - #{exception.backtrace[0..max_range]}"
      logger.error s
    end
  end
end
