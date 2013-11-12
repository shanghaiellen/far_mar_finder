require 'csv'

class Market
  attr_accessor :name, :address, :city, :state, :county, :zip, :id

  def initialize(array)
    @name = array[1]
    @id = array[0]
    @address = array[2]
    @city = array[3]
    @county = array[4]
    @state = array[5]
    @zip = array[6]
  end

  def self.file_location
    "./support/markets.csv"
  end

  def self.all
    CSV.read(file_location).map do |array|
      Market.new(array)
    end
  end

  def self.find(id)
    market = Market.new(CSV.read(file_location).find do |array|
      array[0].to_i == id.to_i
    end)   
  end
# this code does not work. must rework
  # def self.find_all_by_city(match)
  #   array2 = []
  #   CSV.read(file_location).select do |array|
  #      if array[3].downcase == match.downcase
  #       market = Market.new(array)
  #       array2 << market
  #     end
  #   end
  #   puts array2
  # end

  def self.find_all_by_state(match)
    CSV.read(file_location).select do |array|
      array[5].downcase == match.downcase
    end
  end

  def self.find_all_by_county(match)
    CSV.read(file_location).select do |array|
      array[4].downcase == match.downcase
    end
  end

  def self.find_all_by_zip(match)
    CSV.read(file_location).select do |array|
      array[-1].to_i == match.to_i
    end
  end

  def self.find_all_by_address(match)
    CSV.read(file_location).select do |array|
      array[2].downcase == match.downcase
    end
  end

  def self.find_all_by_name(match)
    CSV.read(file_location).select do |array|
      array[1].downcase == match.downcase
    end
  end

  # def 
  # private
  # def read_file
  #   CSV.read(file_location)
  # end

end