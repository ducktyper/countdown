require 'minitest/autorun'
require './test/db_helper'

# Use travel_to
require 'active_support/testing/time_helpers'
include ActiveSupport::Testing::TimeHelpers

# Set timezone
Time.zone = "Pacific/Auckland"
