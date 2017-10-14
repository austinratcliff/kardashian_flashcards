post '/flashcards/:id/guesses' do
  @flashcard = Flashcard.find(params[:id])
  @round = Round.find_by(user_id: session[:user_id])
  @guess = Guess.create(round_id: @round.id, flashcard_id: @flashcard.id, status: false)

  session[:correct_card_ids] = [] unless session[:correct_card_ids]
  session[:correct_cards] = 0 unless session[:correct_cards]
  session[:total_cards] = Flashcard.all.count

  if params[:answer] == @flashcard.answer
    session[:correct_cards] += 1
    session[:correct_card_ids] << @flashcard.id
    @guess.status = true
    #Render the show page where if @guess.status == true
    #display "You are correct!!"
    #Else if @guess.status == false
    #display answer and tell them to try again - also, have a button that says "Next, flashcard" which will post to the path below
    #This isn't restful, but by nature of a flashcard having two sides and a question/answer...it's the best we can do!
    redirect "/rounds/#{@round.id}/flashcards/#{params[:id]}"
  else
    erb :'guesses/show'
  end
end
