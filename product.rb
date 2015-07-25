class Product < ActiveRecord::Base

  def self.create_or_update args
    if (p = find_by(args.slice :barcode))
      p.update args.except(:barcode)
    else
      create args
    end
  end

  def self.map_by barcodes
    barcodes.map {|b| find_by barcode: b}
  end

  def print
    "#{name} $#{"%.2f" % cost}\n"
  end

end

