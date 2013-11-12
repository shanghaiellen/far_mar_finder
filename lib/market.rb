require 'csv'

class Market
  attr_accessor :name, :address, :city, :state, :county, :zip, :id

  def initialize(array)
  #  @name = "blah"
  #  @address = "whatever"
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
    CSV.read(file_location).select do |array|
      array[0] == id
    end
  end

  def self.find_by_city(match)
    CSV.read(file_location).select do |array|
      array[3] == match
    end
  end

  def self.find_by_state(match)
    CSV.read(file_location).select do |array|
      array[5] == match
    end
  end

  def self.find_by_county(match)
    CSV.read(file_location).select do |array|
      array[4] == match
    end
  end

  def self.find_by_zip(match)
    CSV.read(file_location).select do |array|
      array[-1] == match
    end
  end

  def self.find_by_address(match)
    CSV.read(file_location).select do |array|
      array[2] == match
    end
  end

  def self.find_by_name(match)
    CSV.read(file_location).select do |array|
      array[1] == match
    end
  end

  # private
  # def read_file
  #   CSV.read(file_location)
  # end

end