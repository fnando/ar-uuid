# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  add_filter(%r{test/support})
end

require "bundler/setup"
require "ar-uuid"

require "minitest/utils"
require "minitest/autorun"

Dir["#{__dir__}/support/**/*.rb"].sort.each do |file|
  require file
end
