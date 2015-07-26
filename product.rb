class Product < ActiveRecord::Base
  has_one :discount

  def self.create_or_update args
    find_or_initialize_by(barcode: args[:barcode]).update(args)
  end

  def self.map_by barcodes
    barcodes.map {|b| find_by barcode: b}
  end

  def set_discount amount
    (discount || build_discount).update(amount: amount)
  end

  def print
    "#{name} $%.2f\n" % cost
  end

end

