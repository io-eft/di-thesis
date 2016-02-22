class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.references :course, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
