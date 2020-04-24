# frozen_string_literal: true
module Api::V1
  class BaseController < ActionController::API
    include ErrorHandler

    respond_to :json

    def render_with_meta(data, opts = {})
      klass_name =
        if data.respond_to?(:each)
          data.sample.class.name
        else
          data.class.name
        end

      meta = opts.fetch(:meta) { {} }
      meta = meta.merge(status: status_code(opts.fetch(:status) { 200 }))
      meta = meta.merge(status_text: status_text(meta[:status]))

      if opts.fetch(:paginated) { false } && data.respond_to?(:each)
        meta =
          meta.merge(
            pagination: {
              total: opts.fetch(:total) { data.count },
              limit_value: data.limit_value,
              total_pages: data.total_pages,
              current: data.current_page,
              next_page: data.next_page,
              prev_page: data.prev_page,
            }
          )
      end

      serializer_klass = opts.dig(:serializer)
      serializer_klass = "#{klass_name}Serializer".safe_constantize if serializer_klass.nil?

      data = if serializer_klass
               serializer_klass.new(
                 data,
                 include: opts.fetch(:include) { [] }
               )
             else
               { data: data }
             end

      render json: { meta: meta }.merge(data),
             status: opts.fetch(:status) { :ok }
    end

    private

    # Find the user that owns the access token
    def current_resource_owner
      User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    end
    alias current_user current_resource_owner

    def status_code(status)
      if status.is_a?(Integer)
        status
      else
        (Rack::Utils::HTTP_STATUS_CODES.key(status.to_s.titleize) || 200).to_i
      end
    end

    def status_text(status)
      if status.is_a?(Integer)
        (Rack::Utils::HTTP_STATUS_CODES.fetch(status) { 'unknown' }).downcase.tr(' ', '_')
      else
        status.to_s.downcase.tr(' ', '_')
      end
    end
  end
end
