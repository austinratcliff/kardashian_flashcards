post '/flashcards/:id/guesses' do
  @flashcard = Flashcard.find(params[:id])
  # @guess = Guess.new(round_id: ???, flashcard_id: @flashcard.id)
  if params[:answer] == @flashcard.answer
    @flashcard.guesses.update_attribute(status: true)
    redirect '/decks/:deck_id/flashcards/:id'
  else
    erb :'flashcards/show'
  end
end
