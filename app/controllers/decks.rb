get '/sessions_viewer' do
  session.inspect
end

get '/decks' do
  @deck = Deck.first
  #Here we are going to have an array of [1..14] and subtract session[correct_card_ids] from and then sample that array.
  session[:correct_card_ids] = [] unless session[:correct_card_ids]
  full_deck = Array (1..@deck.flashcards.count)
  remaining_cards = full_deck - session[:correct_card_ids]
  p remaining_cards
  p '**********************'
  @flashcard = @deck.flashcards.find(remaining_cards.sample)
  erb :"decks/show"
end


