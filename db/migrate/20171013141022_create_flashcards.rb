class CreateFlashcards < ActiveRecord::Migration
  def change
    create_table :flashcards do |t|
      t.string :question
      t.string :answers
      t.integer :deck_id
      t.timestamps
    end
  end
end
