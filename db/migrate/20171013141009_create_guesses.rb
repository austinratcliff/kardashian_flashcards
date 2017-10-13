class CreateGuesses < ActiveRecord::Migration
  def change
    create_table :guesses do |t|
      t.integer :round_id
      t.integer :flashcard_id
      t.boolean :status
      t.timestamps
    end
  end
end
