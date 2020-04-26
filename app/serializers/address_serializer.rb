# frozen_string_literal: true
class AddressSerializer
  include FastJsonapi::ObjectSerializer
  attributes :title, :address, :country, :city, :county, :zip_code, :phone
end
