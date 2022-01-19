class HomepageController < ApplicationController

  def brewery_search
    valid_params
    token = "Bearer " + ENV['yelp_key']
    @query = valid_params["query"]
    sort_by = valid_params["sort_by"]
    brewery_data = HTTParty.get("https://api.yelp.com/v3/businesses/search?&term=breweries&location=#{@query}&limit=50&sort_by=#{sort_by}",
                             headers: { "Content-Type": "application/json",
                                        "Authorization": token
                             }).body
    @response = adapt_brewery_data(JSON.parse(brewery_data))

    respond_to do |format|
      format.js {}
      format.html
    end
  end



  private

  def adapt_brewery_data(brewery_data)
    brewery_hash = []
    businesses = brewery_data["businesses"]
    businesses.each do |business|
      business_hash = {}
      business_hash["name"] = business["name"]
      business_hash["image_url"] = business["image_url"]
      business_hash["url"] = business["url"]
      business_hash["review_count"] = business["review_count"]
      business_hash["rating"] = render_stars(business["rating"])
      business_hash["location"] = business["location"]["display_address"].join(" ")
      business_hash["phone"] = business["phone"]
      business_hash["display_phone"] = business["display_phone"]
      business_hash["price"] = business["price"]
      business_hash["is_closed"] = business["is_closed"]
      business_hash["distance"] = covert_meters_to_miles(business["distance"])
      brewery_hash << business_hash
    end

    brewery_hash
  end

  def render_stars(value)
    output = ''
    if (1..5).include?(value.floor)
      value.floor.times { output += '<i class="fa fa-star" aria-hidden="true"></i>'}
    end
    if value == (value.floor + 0.5) && value.to_i != 5
      output += '<i class="fa fa-star-half" aria-hidden="true"></i>'
    end
    output.html_safe
  end

  def covert_meters_to_miles(meters)
    meter_in_miles = 0.000621371
    coverted_distance = meters * meter_in_miles
    coverted_distance.round(2)
  end

  def valid_params
    params.permit(:query, :sort_by)
  end
end
