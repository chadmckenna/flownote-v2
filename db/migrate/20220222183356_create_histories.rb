class CreateHistories < ActiveRecord::Migration[7.0]
  def change
    create_table :histories do |t|
      t.references :note, null: false, foreign_key: true
      t.text :content_diff

      t.timestamps
    end
  end
end
