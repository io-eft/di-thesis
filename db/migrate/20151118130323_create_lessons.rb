class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :name
      t.integer :lecturer_id, foreign_key: true

      t.timestamps null: false
    end
  end
end