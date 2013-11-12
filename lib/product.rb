class Product
	attr_accessor :id, :name, :vendor_id

	def initialize(array)
		@id = array[0].to_i
		@name = array[1]
		@vendor_id = array[2]
	end

	def self.file_location
		"./support/products.csv"
	end

	def self.all
		CSV.read(file_location).map do |array|
			Product.new(array)
    end
	end

	def self.find(id)
		 product = Product.new(all.find do |array|
      array[0].to_i == id.to_i
    end)
  end

  def self.find_all_by_name(match)
    array2 = []
    all.select do |array|
      if !array[1].nil?
        if array[1].downcase == match.downcase
          product = Product.new(array)
          array2 << product
        end
      end
    end
    return array2
  end

  def self.find_by_vendor_id(match)
  	array2 = []
    all.select do |array|
      if !array[2].nil?
        if array[2].to_i == match.to_i
          product = Product.new(array)
          array2 << product
        end
      end
    end
    return array2
  end

end
