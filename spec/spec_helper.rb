# MIT LICENSE
#
# $Date: Wed Jul 22 11:43:18 2020 +0200$
# $Rev: v1.0.0-18-ge8d4816$

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'rsct_otp'

RSpec.configure do |config|
  config.disable_monkey_patching!
  config.raise_errors_for_deprecations!
  config.color = true
  config.fail_fast = true
end

require_relative '../lib/rsct_otp'
