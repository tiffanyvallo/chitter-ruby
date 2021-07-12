require 'sinatra/base'
require 'sinatra/reloader'

class Chitter < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    erb :index
  end

  get '/user/new' do
    erb :signup
  end
  
  post '/user/new' do
    User.create(params[:username], params[:email], params[:password])
    redirect '/'
  end

  run! if app_file == $0
end