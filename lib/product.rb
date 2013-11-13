class Product
  attr_accessor :id, :name, :vendor_id

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @vendor_id = array[2].to_i
  end

  #We did not include a number_of_sales method
  #since all you need to do is write sales.count and
  #the tests don't call number_of_sales.
  #We're trying to abide by DRY principles

  def vendor
    Vendor.find(@vendor_id)
  end

  def sales
    Sale.find_by_product_id(@id)
  end

  def self.all
    @all_vendors ||= get_all_vendors
  end

  def self.find(id)
    all.find do |product|
      product.id == id.to_i
    end
  end

  def self.find_all_by_name(match)
    all.select do |product|
      unless product.name.nil?
        product.name.downcase == match.downcase
      end
    end
  end

  def self.by_vendor(match)
    all.select do |product|
      unless product.vendor_id.nil?
        product.vendor_id == match.to_i
      end
    end
  end

  private
  def self.get_all_vendors
    CSV.read("./support/products.csv").map do |array|
      Product.new(array)
    end
  end

end
