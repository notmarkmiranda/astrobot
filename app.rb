#!/usr/bin/env ruby

require 'rubygems'
require 'bundler/setup'
require 'sinatra'

greeting="<h1>Hello From Ruby on Fly!</h1>"

get '/' do
  greeting
end

get '/:name' do
  greeting+"</br>and hello to #{params[:name]}"
end
