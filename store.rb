require './product'
require './purchase'
require './discount'

class Store

  def add_product barcode, name, cost
    Product.create_or_update(barcode: barcode, name: name, cost: cost)
  end

  def product_count
    Product.count
  end

  def calculate_cost barcodes
    Purchase.new_from(barcodes).cost
  end

  def print_receipt barcodes
    Purchase.new_from(barcodes).print_receipt
  end

  def purchase barcodes
    Purchase.new_from(barcodes).tap(&:save).print_receipt
  end

  def purchase_summary
    summary = [["Time","Number of Products","Cost"]]
    Purchase.all.each {|p| summary << [p.display_time, p.item_count, p.cost.to_f]}
    summary
  end

  def add_discount barcode, amount
    product = Product.find_by(barcode: barcode)
    Discount.create_or_update(product: product, amount: amount)
  end

  def delete_discount barcode
    Discount.joins(:product).where(products: {barcode: barcode}).delete_all
  end

end
