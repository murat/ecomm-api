# frozen_string_literal: true
require 'rails_helper'

describe 'InsufficientStockError' do
  it 'includes product availability' do
    expect { raise InsufficientStockError, 20 }.to raise_error(an_instance_of(InsufficientStockError).and(having_attributes(message: 'only 20 product available')))
  end
  it 'includes a generic message' do
    expect { raise InsufficientStockError, 0 }.to raise_error(an_instance_of(InsufficientStockError).and(having_attributes(message: 'product is out stocked')))
  end
end
