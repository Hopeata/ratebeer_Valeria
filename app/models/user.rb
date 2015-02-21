class User < ActiveRecord::Base
  include RatingAverage

  has_secure_password

  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
  validates :password, length: { minimum: 4 }
  validates :password, format: {with: /\d.*[A-Z]|[A-Z].*\d/, message: "has to contain one number and one upper case letter"}

  def favorite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favorite_beer_style
    return nil if ratings.empty?
    styles = beers.group(:style).count
    styles.max_by{|k,v| v}.first
  end

  def favorite_brewery
    return nil if ratings.empty?
    breweries = beers.group(:brewery).count
    breweries.max_by{|k,v| v}.first
  end

  def self.top_activity(n)
    User.all.sort_by{ |u| -(u.ratings.count) }.first(n)
  end


end
