require 'sinatra'
require 'net/http'
require 'json'


ENV['WEATHER_API_KEY'] || raise('no WEATHER_API_KEY provided')
puts "Using WEATHER_API_KEY: #{ENV['WEATHER_API_KEY']}"
$weather_api_base_url = 'http://api.openweathermap.org/data/2.5/'

def send_api_get(url)
  url += '&APPID=' + ENV['WEATHER_API_KEY']
  puts 'Sending get to ' + url
  resp = Net::HTTP.get_response(URI.parse(URI.encode(url)))
  return JSON.parse resp.body
end

# def build_weather_url(endpoint, params_string)
#   return $weather_api_base_url + endpoint + '?' + params_string
# end

def build_current_weather_url(params_string)
  return $weather_api_base_url + 'weather?units=imperial&' + params_string
end


get '/' do
  # Get the location of the user
  erb :index
end

get '/location/:location' do
  # Return weather for location query
  resp_hash = send_api_get(build_current_weather_url("q=#{params['location']}"))
  erb :json_response, :locals => {:resp_hash => resp_hash}
end

get %r{/zip/([\d]{5})($|\?)} do |zip, nothing|
  # Return weather for ZIP code
  resp_hash = send_api_get(build_current_weather_url("zip=#{zip}"))
  erb :json_response, :locals => {:resp_hash => resp_hash}
end

get '/coordinates/:lat/:lon' do
  # Return weather for lat,lon coordinates
  resp_hash = send_api_get(build_current_weather_url("lat=#{params['lat']}&lon=#{params['lon']}"))
  erb :json_response, :locals => {:resp_hash => resp_hash}
end
