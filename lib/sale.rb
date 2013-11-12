require 'time'


class Sale
  attr_accessor :id, :amount, :purchase_time, :vendor_id, :product_id

  def initialize(array)
    @id = array[0].to_i
    @amount = array[1].to_f
    @purchase_time = Time.parse(array[2])
    @vendor_id = array[3].to_i
    @product_id = array[4].to_i
  end

  def self.file_location
    "./support/sales.csv"
  end

  def self.all
    CSV.read(file_location).map do |array|
      Sale.new(array)
    end
  end

  def self.find(id)
    sale = all.find do |array|
      array[0].to_i == id.to_i
    end
  end

  def self.find_by_amount(match)
    array2 = []
    all.select do |array|
      if !array[1].nil?
        if array[1].downcase == match.downcase
          sale = Sale.new(array)
          array2 << sale
        end
      end
    end
    return array2
  end

  def self.find_by_purchase_time(match)
    array2 = []
    all.select do |array|
      if !array[2].nil?
        if array[2].to_time == match
          sale = Sale.new(array)
          array2 << sale
        end
      end
    end
    return array2
  end

  def self.find_by_vendor_id(match)
    array2 = []
    all.select do |array|
      if !array[3].nil?
        if array[3].to_i == match.to_i
          sale = Sale.new(array)
          array2 << sale
        end
      end
    end
    return array2
  end

  def self.find_by_product_id(match)
    array2 = []
    all.select do |array|
      if !array[4].nil?
        if array[4].downcase == match.downcase
          sale = Sale.new(array)
          array2 << sale
        end
      end
    end
    return array2
  end
end
