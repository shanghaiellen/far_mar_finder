class Market
  attr_accessor :name, :address

  def initialize(array)
    @name = "blah"
    @address = "whatever"
  end

  def self.all
    CSV.read("./support/markets.csv").map do |array|
      Market.new(array)
    end
  end
end