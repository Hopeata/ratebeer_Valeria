class BeerClub < ActiveRecord::Base
  has_many :memberships
  has_many :members, through: :memberships, source: :user

  def confirmed_memberships
    memberships.where(confirmed: true)
  end

  def unconfirmed_memberships
    memberships.where(confirmed: [false, nil])
  end

end
