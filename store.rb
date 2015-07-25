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
    purchase_from(barcodes).cost
  end

  def print_receipt barcodes
    purchase_from(barcodes).print_receipt
  end

  def purchase barcodes
    purchase = purchase_from barcodes
    purchase.save
    purchase.print_receipt
  end

  def purchase_summary
    summary = [["Time","Number of Products","Cost"]]
    Purchase.all.each {|p| summary << [p.display_time, p.item_count, p.cost.to_f]}
    summary
  end

  def add_discount barcode, amount
    Discount.create_or_update(product: product_from(barcode), amount: amount)
  end

  def delete_discount barcode
    Discount.where(product: product_from(barcode)).delete_all
  end

  private
  def products_from barcodes
    Product.map_by barcodes
  end

  def product_from barcode
    Product.find_by barcode: barcode
  end

  def existing_discounts_from barcodes
    Discount.map_by(barcodes).compact
  end

  def purchase_from barcodes
    Purchase.new(products: products_from(barcodes), discounts: existing_discounts_from(barcodes))
  end
end
