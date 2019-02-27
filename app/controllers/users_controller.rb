class UsersController < ApplicationController

  # what routes do I need for login?

  # the purpose of this route is to render the login page (form)
  get '/login' do
    puts "**********************FLASH IS "
    puts flash
    erb :login
  end

  # the purpose of this route is to receive the login form,
  # find the user, and log the user in (create a session)
  post '/login' do
    # params looks like: {email: "user@user.com", password: "password"}
    # Find the user
    @user = User.find_by(email: params[:email])
    # Authenticate the user - verify the user is who they say they are
    # they have the credentials - email/password combo

    # if @user is nill then the condition is false
    #which would immiditlly go to the else
    # which also means we wont even hit the this (@user.authenticate(params[:password]))
    if @user && @user.authenticate(params[:password])
    # log the user in - create the user session
    session[:user_id] = @user.id # actually logging the user in
    # redirect to the user's show page
    puts session
    redirect "users/#{@user.id}"
    else
      flash[:message] = "Your credentials were invalid. Please sign up or try again."
      # tell the user they entered invalid credentials
      # redirect them to the login page
      redirect '/login'
    end
  end

  # what routes do I need for signup?
  # this route's job is to render the signup form /
  # a place where I can type in my cradentials in order to signup
  get '/signup' do
    # erb (render) a view
    erb :signup
  end

  # the post method corresponds to the http verb 'post' the argument
  # that we pass in is the url ('/users') then we pass our block.
  ## Expected result:
  post '/users' do
    # did I hit my method and action correctly? If I did I will hit this
    # binding once I submit the form
    #binding.pry

    # here is where we will create a new user and persist the new
    # user to the DB
    # params will look like this:
    # {
    #   "name" => "Elizabeth"
    #   "email" => "elizabeth@e.com"
    #   "password" => "password"
    # }
    # I only want to persist a user that has a name, email, AND
    # password
    if params[:name] != "" && params[:email] != "" && params[:password] != ""
      # valid input
      @user = User.create(params)
      session[:user_id] = @user.id # actually logging the user in
      # where do I go now?
      # let's go to the user show page
      # we use string interpelation because the user id will be going into a string
      # so to convert it into a string we have to use string interpelation

      # what do we have access to when we render a page/ when we use erb?
      # we get access to any instance varable that was created within this block before the erb was called.

      # redirecting: when we redirect we want to send a get request to get the data that we are looking for
      # we are currently in a post request block
      # seperations of concerns: what is the job of this route(  post '/users' do) - its only job is to create a new
      # user!!!!! ONCE it is done creating that new user THEN it will send you on the way to the route or the controller action whos job is to show you the new user(get '/users/:id' ).
      # rule of thumb: rendering should happen from a get request

      # key note: rarely  are we going to render from a post, patch, and delete request
      #  rendering should only happen from a get request
      redirect "/users/#{@user.id}" # the result of this is a brand new get request/ a new http request
    else
      # not valid input
      # it would be better to include a message to the user
      # telling them what is wrong
      redirect '/signup'
    end

    #params: params is going to be the thing that carries the info from this
    # form into this controller action so that we can create and presist
    # that information in the database
  end

  # user SHOW route
  # this routes job is to show the user
  get '/users/:id' do # this will be the user show route
    # what do I need to do first?
    # raise params.inspect
    @user = User.find_by(id: params[:id])
    #binding.pry
    erb :'users/show'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
