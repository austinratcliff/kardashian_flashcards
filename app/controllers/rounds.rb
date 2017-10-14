post '/rounds' do
  session[:correct_cards] = 0 unless session[:correct_cards]
  session[:total_cards] = Flashcard.all.count
  session[:correct_card_ids] = [] unless session[:correct_card_ids]

  count = Flashcard.all.count
  full_deck = Array (1..count)
  remaining_cards = full_deck - session[:correct_card_ids]
  @flashcard = Flashcard.find(remaining_cards.sample)

  #we are using create because techincally we aren't expecting any errors so no need to use Round.new and verify if it saved
  #HEY LIKE, HOW DO WE MAKE THIS DYNAMIC FOR MULTIPLE DECKS?
  @deck = Deck.first
  @round = Round.create(user_id: session[:user_id], deck_id: @deck.id, correct_count: session[:correct_cards])
  redirect "/rounds/#{@round.id}/flashcards/#{@flashcard.id}"
end


#GETTING STUCK ON FLASHCARD.ID OF 6?

#NEED TO IMPLEMENT LOGIC THAT SLOWLY SLICES THE DECK - GETTING CLOSER AND CLOSER TO ZERO CARDS AND END OF ROUND!

get '/rounds/:round_id/flashcards/:id' do
  @deck = Deck.first

  count = Flashcard.all.count
  full_deck = Array (1..count)
  remaining_cards = full_deck - session[:correct_card_ids]
  @flashcard = Flashcard.find(remaining_cards.sample)

  erb :"flashcards/show"
end
