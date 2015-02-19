module RatingAverage
  def average_rating
    ratings.map(&:score).sum.to_f/ratings.count
  end
end