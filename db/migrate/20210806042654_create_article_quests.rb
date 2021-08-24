class CreateArticleQuests < ActiveRecord::Migration[6.0]
  def change
    create_table :article_quests do |t|
      t.references :article, null: false, foreign_key: true
      t.references :quest, null: false, foreign_key: true
      t.timestamps
    end
  end
end
