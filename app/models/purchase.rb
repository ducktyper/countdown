class Purchase < ActiveRecord::Base
  has_and_belongs_to_many :products
  has_and_belongs_to_many :discounts
  before_create :set_purchased_at

  def self.new_from barcodes
    new(products:  Product.map_by(barcodes),
        discounts: Discount.map_by(barcodes).compact)
  end

  def display_time
    purchased_at.strftime("%d/%m/%Y %H:%M:%S")
  end

  def item_count
    products.count
  end

  def cost
    products.map(&:cost).sum - discounts.map(&:amount).sum
  end

  def print_receipt
    products.map(&:print).join + discounts.map(&:print).join +
    "total $%.2f" % cost
  end

  private
  def set_purchased_at
    self.purchased_at = Time.now
  end

end
