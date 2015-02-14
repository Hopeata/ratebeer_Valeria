class BeermappingApi
  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, :expires_in => 7.days) { fetch_places_in(city) }
  end

  def self.place(id)
    Rails.cache.fetch(id, :expires_in => 7.days) { fetch_place(id) }
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"

    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.fetch_place(id)
    url = "http://beermapping.com/webservice/locquery/#{key}/#{id}"
    response = HTTParty.get "#{url}"
    location = response.parsed_response["bmp_locations"]["location"]
    Place.new(location)
  end

  def self.key
    "bca479f1eaef5604493a9ae497784c16"
  end
end