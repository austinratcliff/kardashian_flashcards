get '/users/new' do
  @user = User.new
  erb :"users/new"
end

post '/users' do
  @user = User.new(params[:user])

  if @user.save
    redirect '/sessions/new'
  else
    @errors = @user.errors.full_messages
    erb :"users/new"
  end
end

get '/users/:id' do
  @user = User.find_by(id: params[:id])
  unique_array =  session[:incorrect_card_collection].uniq
 first_round_wrong = unique_array.count
 @first_round_right = session[:total_cards] - first_round_wrong
  @round = Round.find_by(user_id: @user.id)
  @round.update_attributes(correct_count: session[:correct_cards])
  erb :"users/show"
end
