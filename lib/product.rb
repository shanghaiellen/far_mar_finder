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

  def best_day
    # potential code optimization in comments
    # dayhash = sales.number_sold_on_date.group_by { |sale| sale.date}
    # puts dayhash 
    result_hash = {}
    sales.each do |sale|
      result_hash[sale.date] = sale.number_sold_on_date(sale.date)
    end
    result_array = result_array.to_a.sort {|a, b| b[1] <=> a[1]}
    result_array[0]
  end

  def revenue
    sales.inject(0) { |total, sale| total + sale.amount}
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

  def self.most_revenue(n)
    @product_revenue_array ||= get_revenue_array
    sorted = @product_revenue_array.sort {|a, b| b[1] <=> a[1]}
    n.times do |rank|
      puts "#{sorted[rank][0].name} has a revenue of $#{sorted[rank][1].to_f/100}"
      return sorted[rank][0]
    end 

  end

  def self.random
    all.sample
  end

  private
  def self.get_all_vendors
    CSV.read("./support/products.csv").map do |array|
      Product.new(array)
    end
  end

  def self.get_revenue_array
    @product_revenue_array = []
    all.each { |product| @product_revenue_array << [product, product.revenue] }
    @product_revenue_array
  end

end
