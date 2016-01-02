class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code,                              null: false
      t.string :name,                              null: false
      t.integer :lecturer_id, foreign_key: true
      t.text :description
      t.timestamps null: false
    end
  end
end
