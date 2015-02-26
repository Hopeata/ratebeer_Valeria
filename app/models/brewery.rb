class Brewery < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
  validates :year, numericality: {greater_than_or_equal_to: 1042, less_than_or_equal_to: 2015, only_integer: true}

  scope :active, -> { where active:true }
  scope :retired, -> {where active:false }

  has_many :beers, dependent: :destroy
  has_many :ratings, through: :beers

  def self.top(n)

    breweries_with_average_rating = []
    Brewery.all.each do |b|
      if b.average_rating > 0
        breweries_with_average_rating.push(b)
      end
    end

    sorted_by_rating_in_desc_order = breweries_with_average_rating.sort_by{ |b| -(b.average_rating) }.first(n)
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
