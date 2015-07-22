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
