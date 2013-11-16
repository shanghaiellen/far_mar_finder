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
    @vendor = Vendor.by_market(@id)
  end

  def products
    vendsum = []
    @vendor ||= vendors
    @vendor.each { |vendor| vendsum << vendor.products }
    vendsum
  end

  def preferred_vendor
    revenue = []
    @vendor ||= vendors
    @vendor.each { |vendor| revenue << [vendor, vendor.revenue] }
    sorted = revenue.sort {|a, b| b[1] <=> a[1]}
    sorted[0][0]
  end

  def preferred_vendor_by_date(date)
    revenue = []
    @vendor ||= vendors
    @vendor.each do |vendor| 
      vendor.sales.each do |sale|
        if sale.date == date
          revenue << [vendor, vendor.revenue]
        end
      end
    end
    sorted = revenue.sort {|a, b| b[1] <=> a[1]}
    sorted[0][0]
  end

  def worst_vendor_by_date(date)
    revenue = []
    @vendor ||= vendors
    @vendor.each do |vendor| 
      vendor.sales.each do |sale|
        if sale.date == date
          revenue << [vendor, vendor.revenue]
        end
      end
    end
    sorted = revenue.sort {|a, b| a[1] <=> b[1]}
    sorted[0][0]
  end

  def worst_vendor
    revenue = []
    @vendor ||= vendors
    @vendor.each { |vendor| revenue << [vendor, vendor.revenue] }
    sorted = revenue.sort {|a, b| a[1] <=> b[1]}
    sorted[0][0]
  end

  def self.all
    @all_markets ||= get_markets
  end

  def self.find(id)
    all.find do |market|
      market.id == id.to_i
    end
  end

  def self.find_all_by_city(match)
    all.select { |market| market.city.downcase == match.downcase unless market.city.nil? }
  end

#could be shortened with regular expression which might kill nil issue
  def self.find_all_by_state(match)
   all.select do |market|
      unless market.state.nil?
        market.state.downcase == match.downcase
      end
    end
  end

  def self.find_all_by_county(match)
   all.select do |market|
      unless market.county.nil?
        market.county.downcase == match.downcase
      end
    end
  end

  def self.find_all_by_zip(match)
   all.select do |market|
      unless market.zip.nil?
        market.zip.downcase == match.downcase
      end
    end
  end

  def self.find_all_by_address(match)
   all.select do |market|
      unless market.address.nil?
        market.address.downcase == match.downcase
      end
    end
  end

  def self.find_all_by_name(match)
   all.select do |market|
      unless market.name.nil?
        market.name.downcase == match.downcase
      end
    end
  end

  def self.random
    all.sample
  end

  def self.search(search_term)
    all.select do |market|
      unless market.name.nil?
        market.name.downcase.include? search_term.downcase
      end
    end
  end

  private
  def self.get_markets
    CSV.read("./support/markets.csv").map do |array|
      Market.new(array)
    end
  end

end