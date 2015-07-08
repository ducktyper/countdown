require 'minitest/autorun'
require './store'

describe "store" do

  it "has 0 item on creation" do
    store = Store.new
    assert_equal(0, store.item_count())
  end

  it "can add item" do
    store = Store.new
    store.add_item("001", "milk", 10)
    assert_equal(1, store.item_count())
  end

  it "can caculate total cost" do
    store = Store.new
    store.add_item("001", "apple", 10)
    store.add_item("002", "orange", 20)
    assert_equal(30, store.calculate_cost(["001", "002"]))
  end

  it "can print recipt" do
    store = Store.new
    store.add_item("001", "apple", 10)
    store.add_item("002", "orange", 20)
    expected = "apple $10\norange $20\ntotal $30"
    assert_equal(expected, store.print_receipt(["001", "002"]))
  end

end
