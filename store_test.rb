require './test_helper'
require './store'

describe "store" do
  let(:store) do
    store = Store.new
    store.add_product("0001", "apple", 5)
    store.add_product("0002", "orange", 10)
    store
  end

  before(:each) do
    Product.delete_all
    Discount.delete_all
    Purchase.delete_all
    Time.zone = "Pacific/Auckland"
  end

  it "adds product" do
    assert_equal 2, store.product_count
  end

  [
    [nil, "", 10],
    [" ", "snack", 10],
    ["0003", nil, 10],
    ["0003", "", 10],
    ["0003", "snack", nil],
    ["0003", "snack", 0],
    ["0003", "snack", -10],
  ].each do |barcode, name, cost|
    it "invalid product with barcode(#{barcode}), name(#{name}), and cost(#{cost})" do
      assert_raises {store.add_product(barcode, name, cost)}
    end
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
    time = "01/01/2001 00:00:00"
    expect = [
      ["Time", "Number of Products", "Cost"],
      [time, 1, 5]
    ]
    travel_to Time.zone.parse(time) do
      store.purchase(["0001"])
      assert_equal expect, store.purchase_summary
    end
  end

  it "adds discount" do
    store.add_discount("0001", 1)
    assert_equal 4, store.calculate_cost(["0001"])
  end

  [nil, 0, -1].each do |amount|
    it "invalid discount with amount(#{amount})" do
      assert_raises {store.add_discount("0001", amount)}
    end
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
