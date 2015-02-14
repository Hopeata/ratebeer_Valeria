class Beer < ActiveRecord::Base
  include RatingAverage

  validates :name, presence: true
#  validates :style, presence: true

  belongs_to :brewery
  belongs_to :style
  has_many :ratings, dependent: :destroy

  def to_s
    "#{self.brewery.name}: #{self.name}"
  end

end
