post '/rounds' do
  session[:correct_cards] = 0 unless session[:correct_cards]
  session[:total_cards] = Flashcard.all.count
  #we are using create because techincally we aren't expecting any errors so no need to use Round.new and verify if it saved
  #HEY LIKE, HOW DO WE MAKE THIS DYNAMIC FOR MULTIPLE DECKS?
  @deck = Deck.first
  @round = Round.create(user_id: session[:user_id], deck_id: @deck.id, correct_count: session[:correct_cards])
  redirect '/rounds/:round_id/flashcards/:id'
end



get '/rounds/:round_id/flashcards/:id' do
  #if someone is not logged in, they cannot start a round, we redirect them to long aka '/sessions/new'
  authenticate!
  @deck = Deck.first
  @round = Round.find_by(user_id: session[:user_id])
  params[:id] = rand(1..@deck.flashcards.count)
  @flashcard = Flashcard.find(params[:id])
  @flashcard = @deck.flashcards.find(params[:id])
  erb :"flashcards/show"
end
