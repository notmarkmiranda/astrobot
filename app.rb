#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'sinatra'
require 'sinatra/reloader' if development?
require './app/horoscope'


before do
  content_type :json
end

get '/' do
  status 418
  { message: "hey, everything is okay!" }.to_json
end

post '/horoscope' do
  message = Horoscope.get_daily(params[:text])
  status 200
  { text: message, response_type: "in_channel" }.to_json
end
