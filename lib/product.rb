class Product
  attr_accessor :id, :name, :vendor_id

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @vendor_id = array[2].to_i
  end

  def vendor
    Vendor.find(@vendor_id)
  end

  def sales
    Sale.find_by_product_id(@id)
  end

  def self.all
    CSV.read("./support/products.csv").map do |array|
      Product.new(array)
    end
  end

  def self.find(id)
    all.find do |product|
      product.id == id.to_i
    end
  end

  def self.find_all_by_name(match)
    all.select do |product|
      if !product.name.nil?
        product.name.downcase == match.downcase
      end
    end
  end

  def self.by_vendor(match)
    all.select do |product|
      if !product.vendor_id.nil?
        product.vendor_id == match.to_i
      end
    end
  end

end
