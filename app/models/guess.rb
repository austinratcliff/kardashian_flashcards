class Guess < ActiveRecord::Base
  belongs_to :round
  belongs_to :flashcard
end
