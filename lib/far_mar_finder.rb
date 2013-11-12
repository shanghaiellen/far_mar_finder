require 'csv'
require 'time'
require_relative 'market'
require_relative 'vendor'
require_relative 'product'
require_relative 'sale'

# ... Require all of the supporting classes

class FarMarFinder
  # Your code goes here

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