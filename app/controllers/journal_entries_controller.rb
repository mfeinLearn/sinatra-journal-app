class JournalEntriesController < ApplicationController

  # get journal_entries/new to render a form to create new entry
  get '/journal_entries/new' do
    #display a form for creation
    erb :'/journal_entries/new'
  end

  # post journal_entries to create a new journal entry
  post '/journal_entries' do
     #raise params.inspect
    # I want to create a new journal entry and save it to the DB
    # I only want to create a journal entry if a user logged in
    if !logged_in?
      redirect '/'
    end
    # I also only want to save the entry if it has some content
    if params[:content] != ""
      # create a new entry
      @journal_entry = JournalEntry.create(content: params[:content],
      user_id: current_user.id)
      redirect "/journal_entries/#{@journal_entry.id}"
    else
      redirect '/journal_entries/new'
    end
  end
  # show route for a journal entry
  get '/journal_entries/:id' do
    @journal_entry = JournalEntry.find(params[:id])

    erb :'/journal_entries/show'

  end

  # This route should send us to journal_entries/edit.erb which will
  # render an edit form
  get '/journal_entries/:id/edit' do
    erb :'/journal_entries/edit'
  end

  # index route for all journal entries
end
# facts!
# get request will show something that exist
#
# post route: its job is to not render anything its job is to only

# redirect go to-> show or index

# dynamic route: so in the dynamic route the symbol of the
# route is the key of the value which is typed into the url
# dynamic route: The dynamic pieces in the route becomes key value pairs in the
# params hash

# redirect: when we redirect we send a brand new get request
# when that happens all of the varables created within the block
#   that we are passing within this paticular controller route/
#   within this paticular action gets enialiated(redirects destroy
#   instance varables)
#
#   To keep the instance varable alive to be able to be alive in
#   the show page - we can erb/render!!!!!

# erb - a method in sanatra that calls another method called
# render
# erb wants a name of a file reference from our views
