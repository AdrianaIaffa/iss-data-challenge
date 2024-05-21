# frozen_string_literal: true

# myapp.rb
require 'sinatra'
require_relative 'open_notify'

# Allow our templates in views/ to end in `.html.erb`
Tilt.register Tilt::ERBTemplate, 'html.erb'

set :layout, 'views/layout.html.erb'

get '/' do
  erb :index
end

get '/position' do
  iss_now = OpenNotify.iss_now

  erb :position, locals: { data: iss_now }
end

get '/astros' do
  astros = OpenNotify.astros

  content_type :json
  astros.to_json

end

get '/astronauts' do 
  # Get the astronaut data 
  astronaut_data = OpenNotify.astros
  # extract the astronaut information,access json file and from people 
  # get all the info for each "people lol"
  # this is an array of astronauts, they are called hashes[{craft},{name},{craft},{name}]
  astronauts = astronaut_data["people"]
  #console.log using puts
  # puts astronauts
  #locals, add the variale name astronauts and assign it the value of astronauts so i can
  #access my data on my front end like astronauts.name but in ruby astronauts['name']
  erb :astronauts, locals: {astronauts: astronauts}

end

get '/iss_position.json' do
  #fetch ISS position data
  iss_data = OpenNotify.iss_now

  #assing the latitude and longitude to a variable
  #like issData.iss_position.latitude but ruby is with []
  # latitude = iss_data['iss_position']['latitude']
  # longitude = iss_data['iss_position']['longitude']

  #create json response
  #i can actually reuse the iss_data and chage the time stamp
  json_response = {
    # "iss_position": {
    #   "latitude": latitude,
    #   "longitude": longitude
    # },
    "iss_position": iss_data["iss_position"],
    #time.now is a class method in ruby, returns a time object
    #.to_i converts time to an integer, seconds that have passed since 1970 lol
    #Unix epoch format timestamp is standard
    #opennotify said to use unix_time_stamp
    "timestamp": Time.now.to_i,  
    "message": "success"
  }
  #this is like headers in javascript
  content_type :json
  json_response.to_json

end