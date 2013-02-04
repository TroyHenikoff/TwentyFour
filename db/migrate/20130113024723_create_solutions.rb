class CreateSolutions < ActiveRecord::Migration
  def change
    create_table :solutions do |t|
      t.integer :question_id
      t.text :answer

      t.timestamps
    end
  end
end
