require 'rubygems'
require 'sinatra'
require 'erb'
require File.join(File.dirname(__FILE__), 'graph_api_mehods')

get '/' do
 File.read(File.join('public', 'index.html'))
end

get '/friends' do
  erb :friends, :locals => { :friends => GraphApiMethods.new(request.cookies).get_friends}
end

get '/likes' do
  erb :friends, :locals => { :friends => GraphApiMethods.new(request.cookies).get_likes}
end