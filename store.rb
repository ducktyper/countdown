class Store

  def initialize()
    @barcodes = []
    @names    = []
    @prices   = []
  end

  # register item to sell
  # add_item("0001", "apple", 10) => add $10 apple with barcode 0001
  def add_item(barcode, name, price)
    @barcodes << barcode
    @names    << name
    @prices   << price
  end

  # count number of items
  def item_count()
    @names.count
  end

  # calculate total cost of given items
  def calculate_cost(barcodes)
    total = 0
    barcodes.each do |barcode|
      index = @barcodes.index(barcode)
      total = total + @prices[index]
    end
    total
  end

  # print receipt of given items (example)
  # apple $10
  # orange $20
  # total $30
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
