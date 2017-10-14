get '/sessions_viewer' do
  session.inspect
end

get '/decks' do
  @deck = Deck.first

  session[:correct_card_ids] = [] unless session[:correct_card_ids]

  erb :"decks/show"
end


