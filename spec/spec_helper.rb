# frozen_string_literal: true

RSpec.configure do |config|
  config.order = 'random'

  config.before(:each) do
    allow($stdout).to receive(:puts)
    allow($stdout).to receive(:write)
  end
end
