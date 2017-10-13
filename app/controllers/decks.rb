get '/decks' do
  @deck = Deck.first
  random_flashcard = incorrectly_answered_flashcards.sample
  @flashcard = @deck.flashcards.find(random_flashcard)
  erb :"decks/show"
end

get '/decks/:deck_id/flashcards/:id' do
  Round.create ???
  @deck = Deck.first
  random_flashcard = incorrectly_answered_flashcards.sample
  @flashcard = @deck.flashcards.find(random_flashcard)
  erb :"flashcards/show"
end
