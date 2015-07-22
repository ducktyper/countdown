class Product < ActiveRecord::Base

  def print
    "#{name} $#{"%.2f" % cost}\n"
  end

end

