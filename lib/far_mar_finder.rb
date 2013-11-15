require 'csv'
require 'time'
require_relative 'market'
require_relative 'vendor'
require_relative 'product'
require_relative 'sale'

class FarMarFinder

  def markets
    Market
  end

  def vendors
    Vendor
  end

  def products
    Product 
  end

  def sales
    Sale
  end
  
end