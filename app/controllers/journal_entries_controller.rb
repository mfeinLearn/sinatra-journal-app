class JournalEntriesController < ApplicationController

  # get journal_entries/new to render a form to create new entry
  get '/journal_entries/new' do
    #display a form for creation
    erb :'/journal_entries/new'
  end

  # post journal_entries to create a new journal entry
  post '/journal_entries' do
    
  end
  # show route for a journal entry

  # index route for all journal entries
end
# facts!
# get request will show something that exist
#
# post route: its job is to not render anything its job is to only

# redirect go to-> show or index
