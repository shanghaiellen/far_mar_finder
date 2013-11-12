class Vendor

  attr_accessor :id, :name, :no_of_employees, :market_id

  def initialize(array)
    @id = array[0].to_i
    @name = array[1]
    @no_of_employees=array[2].to_i
    @market_id = array[3].to_i
  end

  def self.file_location
    "./support/vendors.csv"
  end

  def self.all
    CSV.read(file_location).map do |array|
      Market.new(array)
    end
  end


  def self.find(id)
    vendor = Vendor.new(CSV.read(file_location).find do |array|
      array[0].to_i == id.to_i
    end)
  end

  def self.find_all_by_name(match)
    array2 = []
    CSV.read(file_location).select do |array|
      if !array[1].nil?
        if array[1].downcase == match.downcase
          market = Market.new(array)
          array2 << market
        end
      end
    end
    return array2
  end

  def self.find_all_by_no_of_employee(match)
    array2 = []
    CSV.read(file_location).select do |array|
      if !array2[2].nil?
        if array[2].downcase == match.downcase
          market = Market.new(array)
          array2 << market
        end
      end
    end
    return array2
  end

  def self.by_market(match)
    array2 = []
    CSV.read(file_location).select do |array|
      if !array[3].nil?
        if array[3].to_i == match.to_i
          market = Market.new(array)
          array2 << market
        end
      end
    end
    return array2
  end

end