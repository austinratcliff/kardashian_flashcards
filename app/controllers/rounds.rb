get '/deck/:id' do
  current_deck = Deck.find(params[:id])
  count = current_deck.flashcards.all.count

  set_current_session_keys(count)


  current_round = Round.new(user_id: session[:user_id], deck_id: current_deck.id, correct_count: session[:correct_cards])
  current_round.save


  redirect to("/rounds/#{current_round.id}/flashcard/show")
end


get '/rounds/:id/flashcard/show' do
  if session[:remaining_cards].size > 0
    session[:current_card_id] = session[:remaining_cards].shift
    @current_card = Flashcard.find(session[:current_card_id])
    erb :"/rounds/current_card", locals: { round_id: params[:id] }
  else
    redirect to("rounds/#{params[:id]}/over")
  end
end


post '/rounds/:id/flashcard/guess' do

  @guess = Guess.new(round_id: params[:id], flashcard_id: session[:current_card_id], status: false)
  @flashcard = Flashcard.find(session[:current_card_id])

  if params[:answer].downcase == @flashcard.answer.downcase
    remove_flashcard(@flashcard)
    redirect to("/rounds/#{params[:id]}/flashcard/show")
  else
    keep_flashcard(@flashcard)
     erb :'guesses/show'
  end
end

get '/rounds/:id/over' do
  @decks = Deck.all
  @first_round_right = calculate_first_round_correct
  @round = Round.find(params[:id])
  @round.update_attributes(correct_count: @first_round_right)
  erb :"rounds/results"
end

