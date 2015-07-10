class Store

  def initialize()
    @barcodes = []
    @names    = []
    @prices   = []
  end

  def add_item(barcode, name, price)
    @barcodes << barcode
    @names    << name
    @prices   << price
  end

  def item_count()
    @names.count
  end

  def calculate_cost(barcodes)
    total = 0
    barcodes.each do |barcode|
      index = @barcodes.index(barcode)
      total = total + @prices[index]
    end
    total
  end

  def print_receipt(barcodes)
    display = ""
    total   = 0
    barcodes.each do |barcode|
      index   = @barcodes.index(barcode)
      name    = @names[index]
      price   = @prices[index]
      display = display + "#{name} $#{price}\n"
      total   = total + price
    end
    display = display + "total $#{total}"
    display
  end

end
