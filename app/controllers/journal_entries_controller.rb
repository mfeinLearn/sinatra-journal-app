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

  # index route for all journal entries
end
# facts!
# get request will show something that exist
#
# post route: its job is to not render anything its job is to only

# redirect go to-> show or index
