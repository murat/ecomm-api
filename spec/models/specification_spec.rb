# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Specification, type: :model do
  it { should belong_to(:product) }

  it { should validate_presence_of(:spec_key) }
  it { should validate_presence_of(:spec_val) }
  it { should validate_uniqueness_of(:spec_key).scoped_to(:product_id).case_insensitive }
end
