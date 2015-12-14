#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'json'
names = Array.new
get '/' do
  "Nothing to see here. Move along."
end
post '/status' do
  values = JSON.parse(request.env["rack.input"].read)
  if values["username"]=='jameson' && values["password"]=='password'
    "{\"success\":1}"
  else
    "{\"success\":0}"
  end
end
post '/login' do
  values = JSON.parse(request.env["rack.input"].read)
  if values["username"]=='jameson' && values["password"]=='password'
  puts values
  #a = `python sub_server.py `+values["date"]+` `+values["hours"]+` `+values["mins"]+` `+values["email"]+` `+values["code"]
  output = system 'python', *["sub_server.py", values["date"], values["hours"], values["mins"], values["email"], values["code"]]
  puts output
    if output == false
        "{\"success\":0}"
    else
        "{\"success\":1}"
    end
  end
end