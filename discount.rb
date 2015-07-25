class Discount < ActiveRecord::Base
  belongs_to :product

  def self.create_or_update args
    if (p = find_by(args.slice :barcode))
      p.update args.except(:barcode)
    else
      create args
    end
  end

  def print
    "#{product.name} -$#{"%.2f" % amount}\n"
  end
end
