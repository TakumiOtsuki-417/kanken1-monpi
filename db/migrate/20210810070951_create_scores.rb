class CreateScores < ActiveRecord::Migration[6.0]
  def change
    create_table :scores do |t|
      t.references :user, null: false, foreign_key: true
      t.references :article, null: false, foreign_key: true
      t.integer :score, null: false
      t.timestamps
    end
  end
end
