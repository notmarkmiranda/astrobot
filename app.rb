#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'net/http'
require 'json'

before do
  content_type 'application/json'
end

get '/' do
  { message: "hey, everything is okay!" }.to_json
end

get '/horoscope' do
  uri = URI('https://any.ge/horoscope/api/?sign=cancer&type=daily&day=today&lang=en')
  api_call = Net::HTTP.get(uri)
  { message: JSON.parse(api_call).first["text"] }.to_json
end

