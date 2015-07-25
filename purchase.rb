class Purchase < ActiveRecord::Base
  has_and_belongs_to_many :products
  has_and_belongs_to_many :discounts
  after_initialize :set_time

  def display_time
    time.strftime("%d/%m/%Y")
  end

  def item_count
    products.count
  end

  def cost
    products.map(&:cost).reduce(:+) - (discounts.map(&:amount).reduce(:+) || 0)
  end

  def print_receipt
    products.map(&:print).join + discounts.map(&:print).join +
    "total $#{"%.2f" % cost}"
  end

  private
  def set_time
    self.time = Time.now
  end

end
