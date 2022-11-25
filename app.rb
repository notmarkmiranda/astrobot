#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'net/http'
require 'json'

ALLOWED_SIGNS = %w(aries taurus gemini cancer leo virgo libra scorpio sagittarius capricorn aquarius pisces)

before do
  content_type :json
end

get '/' do
  status 418
  { message: "hey, everything is okay!" }.to_json
end

post '/horoscope' do
  response =  if ALLOWED_SIGNS.include?(params[:text].downcase)
    horoscope_endpoint ="https://any.ge/horoscope/api/?sign=#{params[:text]}&type=daily&day=today&lang=en"
    uri = URI(horoscope_endpoint)
    json_response(Net::HTTP.get(uri))
  else
    "Hey dummy, that's not a proper zodiac sign. Reach out to Mike Cassano if you need help figuring out what they are. He's an astrological expert!"
  end
  status 200
  { text: "#{params[:text].upcase}: #{response}", response_type: "in_channel" }.to_json
end

def json_response(json)
  horoscope_text = JSON.parse(json)[0]["text"]
  re = /<("[^"]*"|'[^']*'|[^'">])*>/
  horoscope_text.gsub(re, '')
end
