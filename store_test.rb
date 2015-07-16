require 'minitest/autorun'
require './store'

describe "store" do

  it "adds product" do
    store = Store.new()
    store.add_product("0001", "apple", 5)
    assert_equal(1, store.product_count())
  end

  it "adds multiple products" do
    store = Store.new()
    store.add_product("0001", "apple", 5)
    store.add_product("0002", "orange", 5)
    assert_equal(2, store.product_count())
  end

  it "calculate cost" do
    store = Store.new()
    store.add_product("0001", "apple", 5)
    assert_equal(5, store.calculate_cost(["0001"]))
  end

  it "add duplicated named products" do
    store = Store.new()
    store.add_product("0001", "apple", 5)
    store.add_product("0003", "apple", 10)
    assert_equal(15, store.calculate_cost(["0001", "0003"]))
  end

  it "add duplicated barcode replace properties" do
    store = Store.new()
    store.add_product("0001", "apple", 5)
    store.add_product("0001", "orange", 10)
    expact = "orange $10\ntotal $10"
    assert_equal(expact, store.print_receipt(["0001"]))
  end

  it "print receipt" do
    store = Store.new()
    store.add_product("0001", "apple", 5)
    expact = "apple $5\ntotal $5"
    assert_equal(expact, store.print_receipt(["0001"]))
  end

end
