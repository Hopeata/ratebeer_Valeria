module RatingAverage
  def average_rating
    rating = 0.0
    ratings.each do |x|
      rating = rating + x.score
    end
    average = rating / ratings.count
    "Has #{ratings.count} " + "rating".pluralize(ratings.count) + ", average #{average}"
  end
end