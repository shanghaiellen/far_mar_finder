class Vendor

  attr_accessor :id, :name, :no_of_employees, :market_id

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @no_of_employees=array[2].to_i
    @market_id = array[3].to_i
  end

  def market
    Market.find(@id)
  end

  def sales
    Sale.find_by_vendor_id(@id)
  end

  def products
    Product.by_vendor(@id)
  end

  def revenue
    total = 0
    sales.each do |sale|
      total = total + sale.amount
    end
    return total
  end


  def self.all
    CSV.read("./support/vendors.csv").map do |array|
      Vendor.new(array)
    end
  end


  def self.find(id)
    all.find do |vendor|
      vendor.id == id.to_i
    end
  end

  def self.find_all_by_name(match)
    all.select do |vendor|
      if !vendor.name.nil?
        vendor.name.downcase == match.downcase
      end
    end
  end

  def self.find_all_by_no_of_employee(match)
    all.select do |vendor|
      if !vendor.no_of_employees.nil?
        vendor.no_of_employees == match.to_i
      end
    end
  end

  def self.by_market(match)
    all.select do |vendor|
      if !vendor.market_id.nil?
        vendor.market_id == match.to_i
      end
    end
  end

end