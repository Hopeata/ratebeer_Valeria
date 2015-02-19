class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :year, numericality: {greater_than_or_equal_to: 1042, less_than_or_equal_to: 2015, only_integer: true}

  scope :active, -> { where active:true }
  scope :retired, -> {where active:true }

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def self.top(n)
    breweries = []
    Brewery.all.each do |b|
      breweries.push(b)
    end
    sorted_by_rating_in_desc_order = Brewery.all.sort_by{ |b| (b.average_rating||0) }.first(3)
  end

  def print_report
    puts self.name
    puts "established at year #{self.year}"
    puts "number of beers #{self.beers.count}"
  end

  def restart
    self.year = 2015
    puts "changed year to #{year}"
  end

end
