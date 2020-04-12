# frozen_string_literal: true
class BrandSerializer
  include FastJsonapi::ObjectSerializer

  attributes :name
end
