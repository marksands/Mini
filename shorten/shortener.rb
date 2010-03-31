$LOAD_PATH << File.join(Dir.getwd, 'lib')
require 'rubygems'
require 'sinatra'
require 'min'

before do
  @shorten = Shortener.load
end

get '/' do
  erb :home
end

post '/' do
  @js = @shorten.minimize(params['js'])
  redirect '/minify'
end

get '/minify' do
  erb :minify
end




