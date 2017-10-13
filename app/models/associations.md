User
* has_many :rounds

Round
* belongs_to :user
* belongs_to :deck
* has_many :guesses

Guess
* belongs_to :round
* belongs_to :flashcard

Deck
* has_many :rounds
* has_many :flashcards

Flashcard
* belongs_to :deck
* has_many :guesses
