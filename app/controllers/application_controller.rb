require './config/environment'
# require - is actually looking for a name of a file
# and it will execute that file
# we are going to load this stuff(gem(s)) into memory
# -  executes and loads a bunch of ruby code then makes it availble
# for us to use
class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "our_awesome_journal_app"
    # invocked a register method and pass in sinatra flash
    # "flash is just a hash!!"
    # flash only last for one http request
    register Sinatra::Flash
    # I now have access to a hash called flash
    # where I can add key value pairs to a flash message
    # the life cycle of a flash message once I create it
    # is exactly 1 http request

    #NOTE: flash messages must be built at specific points within our controller
    #  that will end in a redirect
    # flash can be used when we create, update, or delete something
    # because create, update, or delete usually ends with a redirect
    # - flash memmages only survive one http request. eg. one http request then they are gone
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

    def authorized_to_edit?(journal_entry)
      journal_entry.user == current_user
    end


    # BUILD HELPER METHOD FOR REDIRECTING IF NOT LOGGED IN!!
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:errors] = "You must be logged in to view the page you tried to view."
        redirect '/'
      end
    end

  end

end
