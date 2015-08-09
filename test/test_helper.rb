require 'minitest/autorun'
require './load_path'
require 'load_database'

# Use travel_to
require 'active_support/testing/time_helpers'
include ActiveSupport::Testing::TimeHelpers

# Set timezone
Time.zone = "Pacific/Auckland"
