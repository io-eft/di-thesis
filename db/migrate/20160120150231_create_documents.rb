class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :name
      t.string :doc
      t.references :assignment, index: true, foreign_key: true

      t.timestamps null: false
    end

  add_index(:documents, [ :assignment_id, :doc ], unique: true)
  end
end
