# frozen_string_literal: true
class CategorySerializer
  include FastJsonapi::ObjectSerializer

  attributes :name

  has_many :children, serializer: CategorySerializer
end
