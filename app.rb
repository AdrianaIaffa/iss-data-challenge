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
  puts astronauts

  erb :astronauts

end