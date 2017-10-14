get '/sessions_viewer' do
  session.inspect
end

get '/decks' do
  @decks = Deck.all
  clear_current_session_keys
  erb :"decks/show"
end


