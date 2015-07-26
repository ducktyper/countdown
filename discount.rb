class Discount < ActiveRecord::Base
  belongs_to :product

  validates :amount, numericality: {greater_than: 0}

  def self.map_by barcodes
    barcodes.map {|b| find_by(product: Product.find_by(barcode: b))}
  end

  def print
    "#{product.name} -$%.2f\n" % amount
  end
end
