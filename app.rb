# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/reloader'
require 'pg'
require 'sinatra/flash'
require_relative './lib/user'
require './db_connection_setup'

class Chitter < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
     register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  get '/user/new' do
    erb :signup
  end

  post '/user/new' do
    if User.find(params[:email])
        # flash[:error] = "User already exists, please log in!"
    else
   user = User.create(params[:username], params[:email], params[:password])
      # flash[:confirm] = "Welcome #{user.username}! Account has been created!"
    end
    redirect '/'
  end

  post '/session/new' do
    search = User.find(params[:email])
    if search.password == params[:password]
      user = session[:user]
      # flash[:confirm] = "Welcome #{user.username}! Successfully logged in!"
      redirect '/feed'
    else
      # flash[:error] = "Incorrect email/password combo, please try again!"
      redirect '/'
    end
  end

  get '/feed' do
    erb :feed
  end

  # run! if app_file == $PROGRAM_NAME
end
