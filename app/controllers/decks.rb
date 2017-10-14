get '/sessions_viewer' do
  session.inspect
end

get '/decks' do
  # @deck = Deck.first
  @decks = Deck.all

  session[:correct_cards] = 0
  session[:remaining_cards] = nil
  session[:current_card_id] = nil
  session[:correct_card_ids] = []
  session[:incorrect_card_id] = ""
  session[:incorrect_card_collection] = []

  erb :"decks/show"
end


