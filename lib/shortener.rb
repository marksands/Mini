require 'rubygems'
require 'sinatra'
require File.expand_path(File.dirname(__FILE__) + '/min.rb')

configure do
  dir = File.dirname(File.expand_path(__FILE__))  
  set :views,  "#{dir}/../views"
  set :public, "#{dir}/../public"
end

before do
  @shorten = Minimizer.new
end

get '/' do
  erb :home
end

get '/css' do
  erb :css
end

post '/minify/js' do
  @js = @shorten.minimize(params['js'])
  erb :minify
end

post '/minify/css' do
  @css = @shorten.minimize_css(params['css'])
  erb :minify
end