class CreatePermissions < ActiveRecord::Migration[5.2]
  def change
    create_table :permissions do |t|
      t.references :survey, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
