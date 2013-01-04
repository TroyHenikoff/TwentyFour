class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :a
      t.integer :b
      t.integer :c
      t.integer :d
      t.integer :difficulty
      t.text :answer

      t.timestamps
    end
  end
end
