class JournalEntriesController < ApplicationController

  get '/journal_entries' do
    @journal_entries = JournalEntry.all
    # we use instance varable so we can access this in the corresponding view
    # an instance varable is scoped to the instance of which it is created

    # this is going to be scoped to the instance of ApplicationController that
    # is current.
    erb :'journal_entries/index'

  end

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
    redirect_if_not_logged_in
    # I also only want to save the entry if it has some content
    if params[:content] != ""
      # create a new entry
      @journal_entry = JournalEntry.create(content: params[:content],
      user_id: current_user.id, title: params[:title], mood: params[:mood])
      flash[:message] = "Journal entry successfully created." if @journal_entry.id
      redirect "/journal_entries/#{@journal_entry.id}"
    else
      flash[:errors] = "Something went wrong - you must provide content for your entry."
      redirect '/journal_entries/new'
    end
  end
  # show route for a journal entry
  get '/journal_entries/:id' do
    set_journal_entry
    #flash[:message] = "you are looking at your show page" # noooo way <------- this is wrong this will fail!!!! a flash can not end with an erb
    erb :'/journal_entries/show'

  end

  # *** MAJOR PROBLEMS!!!! ***
  # 1. RIGHT NOW, ANYONE CAN EDIT ANYONE ELSE'S JOURNAL ENTRIES!!!!
  # 2. ALSO, I CAN EDIT A JOURNAL ENTRY TO BE BLANK!!!!

  # This route should send us to journal_entries/edit.erb which will
  # render an edit form
  get '/journal_entries/:id/edit' do
    set_journal_entry
    redirect_if_not_logged_in
    if authorized_to_edit?(@journal_entry)
      erb :'/journal_entries/edit'
    else
      redirect "users/#{current_user.id}"
    end
  end

  # This action's job is to ...???
  patch '/journal_entries/:id' do
    # 1. find the journal entry
    set_journal_entry
    redirect_if_not_logged_in
    if @journal_entry.user == current_user && params[:content] != ""
  # 2. modify (update) the journal entry
    @journal_entry.update(content: params[:content])
    # 3. redirect to show page
    redirect "/journal_entries/#{@journal_entry.id}"
    else
      redirect "users/#{current_user.id}"
    end
  end

  # the restful convention for deleting something
  delete '/journal_entries/:id' do
    set_journal_entry
    if authorized_to_edit?(@journal_entry)
      # delete the entry
      @journal_entry.destroy
      flash[:message] = "Successfully deleted that entry."
      # go somewhere
      # redirect - because of the seperations of concerns
      redirect '/journal_entries'
    else
      # go somewhere else -- not deleted
      # redirect - because of the seperations of concerns
      redirect '/journal_entries'
    end
  end
  # index route for all journal entries

  private # it is something that we are not
  # going to called outside of this class

  def set_journal_entry
    @journal_entry = JournalEntry.find(params[:id])
  end

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

# Note: method invocations are inside of the controllers


# An activerecord Delete - pluck that thing out

# An activerecord Destroy -

# get request - this job is to showing us something!

# delete, patch and post request actions- USUALLY end in redirects

##### ******* controller action = IS TO ONLY DO **ONE SHIT***/ THING ******* ######
# get request ends in erb BECAUSE we need to show somwthing!!!! ###
