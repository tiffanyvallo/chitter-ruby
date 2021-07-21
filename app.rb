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

  enable :sessions, :method_override
  
  before do
    @user = User.find(column: 'id', value: session[:user_id])
  end

  get '/' do
    erb :index
  end

  get '/user/new' do
    erb :signup
  end

  post '/user/new' do
    if User.find(column: 'email', value: params[:email])
        # flash[:error] = "User already exists, please log in!"
    else
   user = User.create(username: params[:username], email: params[:email], password: params[:password])
      # flash[:confirm] = "Welcome #{user.username}! Account has been created!"
    end
    redirect '/'
  end

  post '/session/new' do
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      # flash[:confirm] = "Welcome #{user.username}! Successfully logged in!"
      redirect '/feed'
    else
      # flash[:error] = "Incorrect email/password combo, please try again!"
      redirect '/'
    end
  end

  post '/session/destroy' do
    session[:user_id] = nil
    # flash[:confirm] = "Successully logged out!"
    redirect '/'
  end

  get '/feed' do
    redirect '/' unless @user
    @peeps = Peep.all
    erb :feed
  end

  post '/feed' do
    peep = Peep.create(user_id: params[:user_id], message: params[:message])
    redirect '/feed'
  end

  # run! if app_file == $PROGRAM_NAME
end
