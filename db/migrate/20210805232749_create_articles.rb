class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :title, null:false
      t.text :content, null:false
      t.integer :level, null:false
      t.integer :genre, null:false
      t.timestamps
    end
  end
end
