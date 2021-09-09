class CreateQuests < ActiveRecord::Migration[6.0]
  def change
    create_table :quests do |t|
      t.text :question, null:false
      t.string :select1, null:false
      t.string :select2, null:false
      t.string :select3, null:false
      t.string :select4, null:false
      t.string :answer, null:false
      t.text :explain, null:false
      t.integer :genre_id, null:false
      t.integer :rank_id, null:false
      t.timestamps
    end
  end
end
