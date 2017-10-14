get '/sessions_viewer' do
  session.inspect
end

get '/decks' do
  # @deck = Deck.first
  @decks = Deck.all
  erb :"decks/show"
end


