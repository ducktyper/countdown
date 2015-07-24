class Discount < ActiveRecord::Base
  belongs_to :product

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
