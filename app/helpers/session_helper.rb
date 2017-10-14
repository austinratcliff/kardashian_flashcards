def current_user
  @current_user ||= User.find_by(id: session[:user_id])
end

def logged_in?
  session[:user_id] != nil
end

def authenticate!
  redirect '/sessions/new' unless logged_in?
end

def set_current_session_keys(count)
  session[:remaining_cards] = Array(1..count)
  session[:correct_cards] = 0 unless session[:correct_cards]
  session[:total_cards] = Flashcard.all.count
  session[:correct_card_ids] = [] unless session[:correct_card_ids]
  session[:incorrect_card_id] = "" unless session[:incorrect_card_id]
  session[:incorrect_card_collection] = [] unless session[:incorrect_card_collection]
end

def clear_current_session_keys
  session[:correct_cards] = 0
  session[:remaining_cards] = nil
  session[:current_card_id] = nil
  session[:correct_card_ids] = []
  session[:incorrect_card_id] = ""
  session[:incorrect_card_collection] = []
end

def remove_flashcard(flashcard)
  #add flashcard to a correct_cards collection
  session[:correct_cards] += 1
  session[:correct_card_ids] << @flashcard.id
end

def keep_flashcard(flashcard)
  #adds incorrect flashcards to the back of the deck
  session[:incorrect_card_id] = @flashcard.id
  session[:incorrect_card_collection] << @flashcard.id
  session[:remaining_cards].push(session[:incorrect_card_id])
end

def calculate_first_round_correct
 unique_array =  session[:incorrect_card_collection].uniq
 first_round_wrong = unique_array.count
 session[:total_cards] - first_round_wrong
end
