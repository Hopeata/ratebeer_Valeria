class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)

  #  session[:last_rating] = "#{rating.beer.name} #{rating.score} points"
    if current_user.nil?
        redirect_to signing_path, notice: 'you should be signed in'
    elsif @rating.save
      current_user.ratings << @rating
      redirect_to user_path current_user
    else
      @beers = Beer.all
      render :new
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end
end