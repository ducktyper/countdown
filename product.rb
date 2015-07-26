class Product < ActiveRecord::Base
  has_one :discount

  def self.create_or_update args
    if (p = find_by(barcode: args[:barcode]))
      p.update args
    else
      create args
    end
  end

  def self.map_by barcodes
    barcodes.map {|b| find_by barcode: b}
  end

  def set_discount amount
    if discount
      discount.update(amount: amount)
    else
      create_discount(amount: amount)
    end
  end

  def print
    "#{name} $%.2f\n" % cost
  end

end

