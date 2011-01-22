require 'rubygems'
require 'sinatra'
require 'erb'
require 'graph_api_methods'

get '/' do
 File.read(File.join('public', 'index.html'))
end

get '/friends' do
  erb :friends, :locals => { :friends => get_friends}
end

get '/likes' do
  erb :friends, :locals => { :friends => get_likes}
end