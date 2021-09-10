class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, null:false
      t.text :content, null:false, limit: 4294967295
      t.integer :rank_id, null:false
      t.integer :genre_id, null:false
      t.timestamps
    end
  end
end
