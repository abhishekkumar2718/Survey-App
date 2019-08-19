class CreateSubmissions < ActiveRecord::Migration[5.2]
  def change
    create_table :submissions do |t|
      t.references :survey, foreign_key: true
      t.references :user, foreign_key: true
      t.text :choices, array: true

      t.timestamps
    end
  end
end
