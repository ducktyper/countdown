require './product'
require './purchase'
require './discount'

class Store

  def initialize
    @products = {}
    @purchases = []
    @discounts = Hash.new(NoDiscount.new)
  end

  def add_product barcode, name, cost
    @products[barcode] = Product.new(barcode, name, cost)
  end

  def product_count
    @products.size
  end

  def calculate_cost barcodes
    purchase_from(barcodes).cost
  end

  def print_receipt barcodes
    purchase_from(barcodes).print_receipt
  end

  def purchase barcodes
    purchase = purchase_from barcodes
    @purchases << purchase
    purchase.print_receipt
  end

  def purchase_summary
    summary = [["Time","Number of Products","Cost"]]
    @purchases.each {|p| summary << [p.display_time, p.item_count, p.cost]}
    summary
  end

  def add_discount barcode, amount
    @discounts[barcode] = Discount.new(product_from(barcode), amount)
  end

  def delete_discount barcode
    @discounts.delete barcode
  end

  private
  def products_from barcodes
    barcodes.map {|b| product_from b}
  end

  def product_from barcode
    @products[barcode]
  end

  def discounts_from barcodes
    barcodes.map {|d| @discounts[d]}
  end

  def purchase_from barcodes
    Purchase.new(products_from(barcodes), discounts_from(barcodes))
  end
end
