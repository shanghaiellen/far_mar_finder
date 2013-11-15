

class Vendor

  attr_accessor :id, :name, :no_of_employees, :market_id

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @no_of_employees=array[2].to_i
    @market_id = array[3].to_i
  end

  def market
    Market.find(@market_id)
  end

  def sales
    @sales ||= Sale.find_by_vendor_id(@id)
  end

  def products
    Product.by_vendor(@id)
  end

  def revenue
    sales.inject(0) { |total, sale| total + sale.amount}
  end

  def revenue_by_date(n)
    date_revenue = 0
    sales.each do |sale|
      if sale.date == n
        date_revenue += sale.amount 
      end
    end
    date_revenue
  end

  def revenue_by_dates(beginning, ending)
    date_revenue = 0
    sales.each do |sale|
      if sale.date >= beginning && sale.date <= ending
        date_revenue += sale.amount 
      end
    end
    date_revenue
  end

  def self.all
    @all_vendors ||= get_all_vendors
  end

  def self.find(id)
    all.find do |vendor|
      vendor.id == id.to_i
    end
  end

  def self.find_all_by_name(match)
    all.select do |vendor|
      unless vendor.name.nil?
        vendor.name.downcase == match.downcase
      end
    end
  end

  def self.find_all_by_no_of_employee(match)
    all.select do |vendor|
      unless vendor.no_of_employees.nil?
        vendor.no_of_employees == match.to_i
      end
    end
  end

  def self.by_market(match)
    all.select do |vendor|
      unless vendor.market_id.nil?
        vendor.market_id == match.to_i
      end
    end
  end

  def self.most_revenue(n)
    @vend_rev_array ||= get_revenue_array
    sorted = @vend_rev_array.sort {|a, b| b[1] <=> a[1]}
    n.times do |rank|
      puts "#{sorted[rank][0].name} has a revenue of $#{sorted[rank][1].to_f/100}"
    end 
  end

  def self.revenue_by_date(n)
    date_revenue = 0
    all.each { |vendor| date_revenue += vendor.revenue_by_date(n)}
    date_revenue
  end

  def self.most_items(n)
    @vend_prod_array ||= get_product_array
    sorted = @vend_prod_array.sort {|a, b| b[1] <=> a[1]}
    n.times do |rank|
      puts "#{sorted[rank][0].name} has #{sorted[rank][1]} products"
    end 
  end

  def self.random
    all.sample
  end  

  private
  def self.get_all_vendors
    CSV.read("./support/vendors.csv").map do |array|
      Vendor.new(array)
    end
  end

  def self.get_revenue_array
    @vend_rev_array = []
    all.each { |vendor| @vend_rev_array << [vendor, vendor.revenue] }
    @vend_rev_array
  end

  def self.get_product_array
    @vend_prod_array = []
    all.each { |vendor| @vend_prod_array << [vendor, vendor.products.count] }
    @vend_prod_array
  end

end