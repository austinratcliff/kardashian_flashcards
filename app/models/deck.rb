class Deck < ActiveRecord::Base
  has_many :rounds
  has_many :flashcards

  validates :name, presence: true
end
