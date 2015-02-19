class Rating < ActiveRecord::Base
  belongs_to :beer
  belongs_to :user

  scope :recent, Rating.limit(5).order("created_at DESC")
  validates :score, numericality: {greater_than_or_equal_to: 1, less_than_or_equal_to: 50, only_integer: true}

  def to_s
    "#{beer.name} #{self.score}"
  end

end
