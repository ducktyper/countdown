class Product
  attr_reader :barcode, :name, :cost

  def initialize barcode, name, cost
    @barcode = barcode
    @name    = name
    @cost    = cost
  end

  def print
    "#{name} $#{"%.2f" % cost}\n"
  end

end

class Purchase
  attr_reader :time, :products, :discounts

  def initialize products, cost, discounts
    @time = Time.now
    @products = products
    @discounts = discounts
  end

  def display_time
    @time.strftime("%d/%m/%Y")
  end

  def item_count
    @products.size
  end

  def cost
    products.inject(0) { |total, product| total + product.cost } -
    discounts.inject(0) { |total, discount| total + discount.amount}
  end

end

class Discount
  attr_reader :product, :amount

  def initialize product, amount
    @product = product
    @amount = amount
  end

  def print
    "#{product.name} -$#{"%.2f" % amount}\n"
  end

end

class NoDiscount
  def amount
    0
  end
  def print
    ""
  end
end

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
    barcodes.inject(0) do |total, barcode|
      total + @products[barcode].cost - @discounts[barcode].amount
    end
  end

  def print_receipt barcodes
    print_cost(barcodes) + print_discount(barcodes) + print_total(barcodes)
  end

  def purchase barcodes
    @purchases << Purchase.new(products_from(barcodes), calculate_cost(barcodes), discounts_from(barcodes))
    print_receipt(barcodes)
  end

  def purchase_summary
    summary = [["Time","Number of Products","Cost"]]
    @purchases.each {|p| summary << [p.display_time, p.item_count, p.cost]}
    summary
  end

  def add_discount barcode, amount
    @discounts[barcode] = Discount.new(product_from(barcode), amount)
  end

  private
  def print_cost barcodes
    barcodes.inject("") {|receipt, barcode| receipt + @products[barcode].print}
  end

  def print_discount barcodes
    barcodes.inject("") {|receipt, barcode| receipt + @discounts[barcode].print}
  end

  def print_total barcodes
    "total $#{"%.2f" % calculate_cost(barcodes)}"
  end

  def products_from barcodes
    barcodes.map {|b| product_from b}
  end

  def product_from barcode
    @products[barcode]
  end

  def discounts_from barcodes
    barcodes.map {|d| @discounts[d]}
  end
end
