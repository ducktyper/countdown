require 'test_helper'
require 'rack/test'
require 'countdown_app'

describe "countdown_app" do
  include Rack::Test::Methods
  let(:app) {Rails.application}

  it "add_product" do
    get "add_product", {barcode: "0001", name: "apple", cost: 5}
    assert_equal "Product count: 1", last_response.body
  end
end
