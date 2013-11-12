require 'csv'
require_relative 'vendor'

class Market
  attr_accessor :name, :address, :city, :state, :county, :zip, :id

  def initialize(array)
    @name = array[1]
    @id = array[0].to_i
    @address = array[2]
    @city = array[3]
    @county = array[4]
    @state = array[5]
    @zip = array[6]
  end

  def vendors
    Vendor.by_market(@id)
  end

  def self.all
    CSV.read("./support/markets.csv").map do |array|
      Market.new(array)
    end
  end

  def self.find(id)
    all.find do |market|
      market.id == id.to_i
    end
  end

  def self.find_all_by_city(match)
    all.select do |market|
      if !market.city.nil?
        market.city.downcase == match.downcase
      end
    end
  end

  def self.find_all_by_state(match)
   all.select do |market|
      if !market.state.nil?
        market.state.downcase == match.downcase
      end
    end
  end

  def self.find_all_by_county(match)
   all.select do |market|
      if !market.county.nil?
        market.county.downcase == match.downcase
      end
    end
  end

  def self.find_all_by_zip(match)
   all.select do |market|
      if !market.zip.nil?
        market.zip.downcase == match.downcase
      end
    end
  end

  def self.find_all_by_address(match)
   all.select do |market|
      if !market.address.nil?
        market.address.downcase == match.downcase
      end
    end
  end

  def self.find_all_by_name(match)
   all.select do |market|
      if !market.name.nil?
        market.name.downcase == match.downcase
      end
    end
  end

  # def 
  # private
  # def read_file
  #   CSV.read(file_location)
  # end

end