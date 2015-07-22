require 'minitest/autorun'
require 'active_record'
require './store'

ActiveRecord::Base.establish_connection adapter: "sqlite3", database: ":memory:"
ActiveRecord::Schema.define do
  create_table "products" do |t|
    t.string   "barcode",       limit: 255
    t.string   "name",          limit: 255
    t.decimal  "cost",          precision: 8, scale: 2
  end
end

describe "store" do
  let(:store) do
    store = Store.new
    store.add_product("0001", "apple", 5)
    store.add_product("0002", "orange", 10)
    store
  end

  it "adds product" do
    assert_equal 2, store.product_count
  end

  it "calculates cost" do
    assert_equal 5, store.calculate_cost(["0001"])
  end

  it "adds duplicated named products" do
    store.add_product("0003", "apple", 10)
    assert_equal 15, store.calculate_cost(["0001", "0003"])
  end

  it "adds duplicated barcode replace properties" do
    store.add_product("0001", "jazz apple", 10)
    expect = "jazz apple $10.00\ntotal $10.00"
    assert_equal expect, store.print_receipt(["0001"])
  end

  it "prints receipt" do
    expect = "apple $5.00\ntotal $5.00"
    assert_equal expect, store.print_receipt(["0001"])
  end

  it "purchases products" do
    expect = "apple $5.00\ntotal $5.00"
    assert_equal expect, store.purchase(["0001"])
  end

  it "shows purchase summary" do
    store.purchase(["0001"])
    time = Time.now.strftime("%d/%m/%Y")
    expect = [
      ["Time", "Number of Products", "Cost"],
      [time, 1, 5]
    ]
    assert_equal expect, store.purchase_summary
  end

  it "adds discount" do
    store.add_discount("0001", 1)
    assert_equal 4, store.calculate_cost(["0001"])
  end

  it "shows receipt with discount" do
    store.add_discount("0001", 1)
    expect = "apple $5.00\napple -$1.00\ntotal $4.00"
    assert_equal expect, store.purchase(["0001"])
  end

  it "adds discount override existing one" do
    store.add_discount("0001", 1)
    store.add_discount("0001", 2)
    assert_equal 3, store.calculate_cost(["0001"])
  end

  it "deletes discount" do
    store.add_discount("0001", 1)
    store.delete_discount("0001")
    assert_equal 5, store.calculate_cost(["0001"])
  end

end
