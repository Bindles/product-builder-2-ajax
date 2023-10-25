class PagesController < ApplicationController
  def index
  end

  def home
  end

  def fetchEV
    # Import the required libraries (You can keep these statements at the top of the controller)
    require 'httparty'
    require 'json'

    # Define the URL where the JSON data is located
    url = 'https://www.eightvape.com/products/lost-vape-ursa-nano-pod-kit.json'

    # Make an HTTP GET request to the URL
    response = HTTParty.get(url)

    # Check if the request was successful (HTTP status code 200)
    if response.code == 200
      # Parse the JSON response
      parsed_data = JSON.parse(response.body)

      # Access the product ID, title, and price
      @product_id = parsed_data['product']['id']
      @product_title = parsed_data['product']['title']
      @product_type = parsed_data['product']['product_type']
      @product_body_html = parsed_data['product']['body_html']
      @product_vendor = parsed_data['product']['vendor']

      # For example, let's access the price of the first variant (Wave Black)
      @first_variant_price = parsed_data['product']['variants'][0]['price']

      # Render the view
      render :fetch_ev
    else
      puts "Failed to retrieve data. HTTP status code: #{response.code}"
      # Handle the error as needed
    end
  end
end
