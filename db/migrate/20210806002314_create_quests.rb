class CreateQuests < ActiveRecord::Migration[6.0]
  def change
    create_table :quests do |t|
      t.text :question
      t.string :select1
      t.string :select2
      t.string :select3
      t.string :select4
      t.string :answer
      t.text :explain
      t.integer :genre
      t.integer :level
      t.timestamps
    end
  end
end
