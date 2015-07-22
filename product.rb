class Product < ActiveRecord::Base

  def self.create_or_update args
    if (p = find_by(barcode: args[:barcode]))
      p.update args.except(:barcode)
    else
      create args
    end
  end

  def print
    "#{name} $#{"%.2f" % cost}\n"
  end

end

