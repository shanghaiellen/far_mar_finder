require 'time'


class Sale
  attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

  def initialize(array)
    @id = array[0].to_i
    @amount = array[1].to_i
    @purchase_time = Time.parse(array[2])
    @vendor_id = array[3].to_i
    @product_id = array[4].to_i
  end

  def vendor
    Vendor.find(@vendor_id)
  end

  def product
    Product.find(@product_id)
  end

  def date
    @purchase_time.to_date
  end

  def number_sold_on_date(match)
    number = Sale.all.select do |sale|
      unless sale.vendor_id.nil?
        sale.purchase_time.to_date == match
      end
    end
    number.length
  end

  def self.all
    @all_sales ||= get_all_sales
  end

  def self.best_day
    result_hash = {}
    all.each do |sale|
      result_hash[sale.date] ||= 0
      result_hash[sale.date] += 1
    end
    result_array = result_hash.to_a.sort {|a, b| b[1] <=> a[1]}
    result_array[0]
  end
  #true ? "I'm true" : "I'm false" 


  def self.find(id)
    all.find do |sale|
      sale.id == id.to_i
    end
  end

  def self.find_by_amount(match)
    all.select do |sale|
      unless sale.amount.nil?
        sale.amount == match.to_i
      end
    end
  end

  def self.find_by_purchase_time(match)
    all.select do |sale|
      unless sale.purchase_time.nil?
        sale.purchase_time == match.to_time
      end
    end
  end

  def self.find_by_vendor_id(match)
    all.select do |sale|
      unless sale.vendor_id.nil?
        sale.vendor_id == match.to_i
      end
    end
  end

  def self.find_by_date(match)
    all.select do |sale|
      unless sale.vendor_id.nil?
        sale.purchase_time.to_date == match
      end
    end
  end


  def self.find_by_product_id(match)
    all.select do |sale|
      unless sale.product_id.nil?
        sale.product_id == match.to_i
      end
    end
  end

  def self.between(beginning_time, end_time)
      all.select do |sale|
      unless sale.purchase_time.nil?
        sale.purchase_time >= beginning_time && sale.purchase_time <= end_time
      end
    end
  end

  def self.random
    all.sample
  end

  private
  def self.get_all_sales
    CSV.read("./support/sales.csv").map do |array|
      Sale.new(array)
    end
  end

end
