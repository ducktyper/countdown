class Purchase
  attr_reader :time, :products, :discounts

  def initialize products, discounts
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
    products.map(&:cost).reduce(:+) - discounts.map(&:amount).reduce(:+)
  end

  def print_receipt
    @products.map(&:print).join + @discounts.map(&:print).join +
    "total $#{"%.2f" % cost}"
  end

end
