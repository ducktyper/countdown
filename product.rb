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

