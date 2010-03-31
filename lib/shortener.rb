require 'rubygems'
require 'sinatra/base'
require File.expand_path(File.dirname(__FILE__) + '/min.rb')

class Application < Sinatra::Base
  
  attr_accessor :js

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

  post '/' do
    @@js = @shorten.minimize(params['js'])
    redirect '/minify'
  end

  get '/minify' do
    @js = @@js.gsub(/^\s+/,'').gsub(/^\t+/,'')
    erb :minify
  end
  
end