class Product
  attr_reader :barcode, :name, :cost

  def initialize barcode, name, cost
    @barcode = barcode
    @name    = name
    @cost    = cost
  end

end

class Purchase
  attr_reader :time, :barcodes, :cost

  def initialize barcodes, cost
    @time = Time.now
    @barcodes = barcodes
    @cost = cost
  end

  def display_time
    @time.strftime("%d/%m/%Y")
  end

  def item_count
    @barcodes.size
  end

end

class Discount
  attr_reader :barcode, :amount

  def initialize barcode, amount
    @barcode = barcode
    @amount = amount
  end

end

class NoDiscount
  def amount
    0
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
    barcodes.inject(0) {|total, barcode| total + @products[barcode].cost - discount_cost(barcode)}
  end

  def print_receipt barcodes
    print_cost(barcodes) + print_discount(barcodes) + print_total(barcodes)
  end

  def purchase barcodes
    @purchases << Purchase.new(barcodes, calculate_cost(barcodes))
    print_receipt(barcodes)
  end

  def purchase_summary
    summary = [["Time","Number of Products","Cost"]]
    @purchases.each {|p| summary << [p.display_time, p.item_count, p.cost]}
    summary
  end

  def add_discount barcode, amount
    @discounts[barcode] = Discount.new(barcode, amount)
  end

  private
  def print_cost barcodes
    barcodes.inject("") do |receipt, barcode|
      product = @products[barcode]
      receipt + "#{product.name} $#{"%.2f" % product.cost}\n"
    end
  end

  def print_discount barcodes
    barcodes.inject("") do |receipt, barcode|
      product  = @products[barcode]
      discount = @discounts[barcode]
      if !discount.is_a? NoDiscount
        receipt + "#{product.name} -$#{"%.2f" % discount.amount}\n"
      else
        receipt
      end
    end
  end

  def print_total barcodes
    "total $#{"%.2f" % calculate_cost(barcodes)}"
  end

  def discount_cost barcode
    if (discount = @discounts[barcode])
      discount.amount
    else
      0
    end
  end

end
