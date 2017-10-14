get '/deck/:id' do
  #Find deck in database
  current_deck = Deck.find(params[:id])
  count = current_deck.flashcards.all.count
  #Set session variables
  session[:remaining_cards] = Array(1..count)
  session[:correct_cards] = 0 unless session[:correct_cards]
  session[:total_cards] = Flashcard.all.count
  session[:correct_card_ids] = [] unless session[:correct_card_ids]

  current_round = Round.new(user_id: session[:user_id], deck_id: current_deck.id, correct_count: session[:correct_cards])
  current_round.save
  p current_round.errors
  redirect to("/rounds/#{current_round.id}/flashcard/show")
end


get '/rounds/:id/flashcard/show' do
  if session[:remaining_cards].size > 0
    session[:current_card_id] = session[:remaining_cards].pop
    @current_card = Flashcard.find(session[:current_card_id])
    erb :"/rounds/current_card", locals: { round_id: params[:id] }
  else
    redirect to("rounds/#{params[:id]}/over")
  end
end


post '/rounds/:id/flashcard/guess' do

  @guess = Guess.new(round_id: params[:id], flashcard_id: session[:current_card_id], status: false)
  @flashcard = Flashcard.find(session[:current_card_id])
  if params[:answer] == @flashcard.answer
    session[:correct_cards] += 1
    session[:correct_card_ids] << @flashcard.id
    @guess.status = true
    @guess.save
    redirect to("/rounds/#{params[:id]}/flashcard/show")
  else
     erb :'guesses/show'
  end
end


get '/rounds/:id/over' do
  @all_guesses = Round.find(params[:id]).guesses
  session[:card_ids] = nil
  session[:current_card_id] = nil
  erb :"rounds/results"
end

