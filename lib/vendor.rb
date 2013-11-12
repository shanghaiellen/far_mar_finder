class Vendor

  attr_accessor :id, :name, :num_of_employees, :market_id

  def self.file_location
    "./support/vendors.csv"
  end

  def self.all
    CSV.read(file_location).map do |array|
      Market.new(array)
    end
  end


  def self.find(id)
    CSV.read(file_location).find do |array|
      array[0].to_i == id.to_i
    end
  end

    def self.find_all_by_name(match)
    CSV.read(file_location).select do |array|
      array[1].downcase == match.downcase
    end
  end

    def self.find_all_by_num_of_employee(match)
    CSV.read(file_location).select do |array|
      array[2].downcase == match.downcase
    end
  end

    def self.find_all_by_market_id(match)
    CSV.read(file_location).select do |array|
      array[3].to_i == match.to_i
    end
  end

end