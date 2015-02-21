class Style < ActiveRecord::Base
  include RatingAverage

  has_many :beers
  has_many :ratings, through: :beers

  def self.top(n)

    styles_with_average_rating = []
    Style.all.each do |s|
      if s.average_rating > 0
        styles_with_average_rating.push(s)
      end
    end

    sorted_by_rating_in_desc_order = styles_with_average_rating.sort_by{ |s| -(s.average_rating) }.first(n)
  end

  def to_s
    name
  end
end