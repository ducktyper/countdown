class Product
  attr_reader :barcode, :name, :cost

  def initialize barcode, name, cost
    @barcode = barcode
    @name    = name
    @cost    = cost
  end

end

class Store

  def initialize
    @products = {}
  end

  def add_product barcode, name, cost
    @products[barcode] = Product.new(barcode, name, cost)
  end

  def product_count
    @products.size
  end

  def calculate_cost barcodes
    barcodes.inject(0) {|total, barcode| total + @products[barcode].cost}
  end

  def print_receipt barcodes
    print_cost(barcodes) + print_total(barcodes)
  end

  private
  def print_cost barcodes
    barcodes.inject("") do |receipt, barcode|
      product = @products[barcode]
      receipt + "#{product.name} $#{product.cost}\n"
    end
  end

  def print_total barcodes
    "total $#{calculate_cost(barcodes)}"
  end

end
