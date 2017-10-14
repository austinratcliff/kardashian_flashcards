get '/decks' do
  @deck = Deck.first
  params[:id] = rand(1..@deck.flashcards.count)
  @flashcard = @deck.flashcards.find(params[:id])
  erb :"decks/show"
end

get '/decks/:deck_id/flashcards/:id' do
  @deck = Deck.first
  params[:id] = rand(1..@deck.flashcards.count)
  @flashcard = @deck.flashcards.find(params[:id])
  erb :"flashcards/show"
end
