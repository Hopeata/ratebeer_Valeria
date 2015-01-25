class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
  end

  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  def new
    @rating =Rating.new
    @beers = Beer.all
  end

  def create
    Rating.create params.require(:rating).permit(:score, :beer_id)
    redirect_to ratings_path
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete
    redirect_to ratings_path
  end
end