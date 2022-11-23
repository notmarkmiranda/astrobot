#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'sinatra'

get '/' do
  "<p>AstrologyBot here, all is well</p>"
end

get '/:name' do
  "<p>Are you here to get your horoscope, #{params[:name]}</p>"
end
