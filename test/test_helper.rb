# Add load paths
$LOAD_PATH.unshift File.expand_path('../../', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../test', __FILE__)
$LOAD_PATH.unshift File.expand_path('../../app/models', __FILE__)

require 'minitest/autorun'
require 'db_helper'

# Use travel_to
require 'active_support/testing/time_helpers'
include ActiveSupport::Testing::TimeHelpers

# Set timezone
Time.zone = "Pacific/Auckland"
