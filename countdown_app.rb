# Run app: type 'rackup -p 3000' from terminal

require './load_path'
require 'load_database'

require "action_controller/railtie"
require "store"

class CountdownApp < Rails::Application
  config.secret_key_base = '1519cecd4f8c4c0bb70cfe8413a33250'
  routes.append do
    get '/add_product', to: 'store#add_product'
  end
end

class StoreController < ActionController::Base
  def add_product
    store = Store.new
    store.add_product(params[:barcode], params[:name], params[:cost])
    render text: "Product count: #{store.product_count}"
  end
end

CountdownApp.initialize!
