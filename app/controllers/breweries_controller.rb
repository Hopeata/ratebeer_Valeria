class BreweriesController < ApplicationController
  before_action :set_brewery, only: [:show, :edit, :update, :destroy]
  before_action :ensure_that_signed_in, :except => [:index, :show]
  before_action :skip_if_cached, only:[:index]
  # GET /breweries
  # GET /breweries.json
  def skip_if_cached
    @order = params[:order] || 'name'
    return render :index if fragment_exist?( "brewerylist"  )
  end

  def index
      @breweries = Brewery.all
      @active_breweries = Brewery.active
      @retired_breweries = Brewery.retired

    order = params[:order] || 'name'

    @breweries = case order
                          when 'name' && session[:last_order].nil? then @breweries.sort_by{|b| b.name}
                            session[:last_order] = order
                            when 'year' && session[:last_order].nil? then @breweries.sort_by{|b| b.year}
                            session[:last_order] = order
                          when 'name' then @breweries.reverse!
                          session[:last_order] = nil
                          when 'year' then @breweries.reverse!
                          session[:last_order] = nil
                        end

#    render :panimot
  end

  def list
  end
  # GET /breweries/1
  # GET /breweries/1.json
  def show
  end

  # GET /breweries/new
  def new
    @brewery = Brewery.new
  end

  # GET /breweries/1/edit
  def edit
  end

  # POST /breweries
  # POST /breweries.json
  def create
    @brewery = Brewery.new(brewery_params)
    expire_fragment :action => :index
    respond_to do |format|
      if @brewery.save
        format.html { redirect_to @brewery, notice: 'Brewery was successfully created.' }
        format.json { render action: 'show', status: :created, location: @brewery }
      else
        format.html { render action: 'new' }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breweries/1
  # PATCH/PUT /breweries/1.json
  def update
    ["brewerylist-name", "brewerylist-year"].each{ |f| expire_fragment(f) }
    respond_to do |format|
      if @brewery.update(brewery_params)
        format.html { redirect_to @brewery, notice: 'Brewery was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @brewery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breweries/1
  # DELETE /breweries/1.json
  def destroy
    @brewery.destroy
    ["brewerylist-name", "brewerylist-year"].each{ |f| expire_fragment(f) }
    respond_to do |format|
      format.html { redirect_to breweries_url }
      format.json { head :no_content }
    end
  end

  def toggle_activity
    brewery = Brewery.find(params[:id])
    brewery.update_attribute :active, (not brewery.active)

    new_status = brewery.active? ? "active" : "retired"

    redirect_to :back, notice:"brewery activity status changed to #{new_status}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_brewery
      @brewery = Brewery.find(params[:id])
    end

  private

 # def authenticate
 #   admin_accounts = {"admin" => "secret", "pekka" => "beer", "arto" => "foobar", "matti" => "ittam"}
 #   authenticate_or_request_with_http_basic do |username, password |
 #     admin_accounts.has_key?(username) and admin_accounts[username] == password
 #   end
 # end


    # Never trust parameters from the scary internet, only allow the white list through.
    def brewery_params
      params.require(:brewery).permit(:name, :year, :active)
    end
end
