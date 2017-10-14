get '/deck/:id' do
  #Find deck in database
  current_deck = Deck.find(params[:id])
  count = current_deck.flashcards.all.count
  #Set session variables
  session[:remaining_cards] = Array(1..count)
  session[:correct_cards] = 0 unless session[:correct_cards]
  session[:total_cards] = Flashcard.all.count
  session[:correct_card_ids] = [] unless session[:correct_card_ids]
  session[:incorrect_card_id] = "" unless session[:incorrect_card_id]
  session[:incorrect_card_collection] = [] unless session[:incorrect_card_collection]

  current_round = Round.new(user_id: session[:user_id], deck_id: current_deck.id, correct_count: session[:correct_cards])
  current_round.save
  p current_round.errors
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
    session[:correct_cards] += 1
    session[:correct_card_ids] << @flashcard.id
    @guess.status = true
    @guess.save
    redirect to("/rounds/#{params[:id]}/flashcard/show")
  else
    session[:incorrect_card_id] = @flashcard.id
    session[:incorrect_card_collection] << @flashcard.id
    session[:remaining_cards].push(session[:incorrect_card_id])
     erb :'guesses/show'
  end
end

get '/rounds/:id/over' do
 unique_array =  session[:incorrect_card_collection].uniq
 first_round_wrong = unique_array.count
 @first_round_right = session[:total_cards] - first_round_wrong
  erb :"rounds/results"
end

