# Add load paths
["", "test", "app/models"].each do |path|
  $LOAD_PATH.unshift File.expand_path("../../#{path}", __FILE__)
end

require 'minitest/autorun'
require 'db_helper'

# Use travel_to
require 'active_support/testing/time_helpers'
include ActiveSupport::Testing::TimeHelpers

# Set timezone
Time.zone = "Pacific/Auckland"
