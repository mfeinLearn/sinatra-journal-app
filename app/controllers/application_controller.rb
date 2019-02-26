require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "our_awesome_journal_app"
  end

# 1. we matched this route
# 2. we checked to see if we are logged in
  # 3. if we are going to the current users show page
  # 
# 4. otherwise we are gonig to redirect to the welcome page
  get "/" do
    if logged_in?
      redirect "/users/#{current_user.id}"
    else
      erb :welcome
    end

  end

  helpers do

    def logged_in?
      # true if user is logged in, otherwise false
      !!current_user
    end

    def current_user
    @current_user ||= User.find_by(id: session[:user_id])
    end

  end

end
