class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
#  validates :style, presence: true

  belongs_to :brewery, touch: true
  belongs_to :style
  has_many :ratings, :dependent => :destroy

  def self.top(n)

    beers_with_average_rating = []
    Beer.all.each do |b|
      if b.average_rating > 0
        beers_with_average_rating.push(b)
      end
    end

    sorted_by_rating_in_desc_order = beers_with_average_rating.sort_by{ |b| -(b.average_rating) }.first(n)
  end

  def to_s
    "#{self.brewery.name}: #{self.name}"
  end

end
