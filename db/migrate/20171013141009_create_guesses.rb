class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :round_id
      t.integer :flashcard_id
      t.integer :correct_count
      t.timestamps
    end
  end
end
