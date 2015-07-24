require 'minitest/autorun'
require 'active_record'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
ActiveRecord::Schema.define do
  create_table "products" do |t|
    t.string   "barcode",       limit: 255
    t.string   "name",          limit: 255
    t.decimal  "cost",          precision: 8, scale: 2
  end
  create_table "discounts" do |t|
    t.integer  "product_id",    limit: 4
    t.decimal  "amount",        precision: 8, scale: 2
  end
end
