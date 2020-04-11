# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Brand, type: :model do
  it { should have_many(:products).dependent(:nullify) }

  it { should validate_presence_of(:name) }
end
