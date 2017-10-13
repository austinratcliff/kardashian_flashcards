require 'CSV'

CSV.foreach("db/Kardashian_FCs.csv", headers: true, header_converters: :symbol) do |row|

  deck = Deck.find_or_create_by!(name: row[:deck_name])
  flashcard = Flashcard.find_or_create_by!(question: row[:question], answer: row[:answer], deck_id: deck.id)

end
