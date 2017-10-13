get '/decks' do
  p @deck = Deck.first
  p params[:id] = rand(1..@deck.flashcards.count)
  p @flashcard = @deck.flashcards.find(params[:id])
  p @flashcard.id
  erb :"decks/show"
end

get '/decks/:deck_id/flashcards/:id' do
  @deck = Deck.find(params[:deck_id])
  erb :"flashcards/show"
end
