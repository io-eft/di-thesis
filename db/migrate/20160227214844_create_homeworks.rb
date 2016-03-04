class CreateHomeworks < ActiveRecord::Migration
  def change
    create_table :homeworks do |t|
      t.references :user, index: true, foreign_key: true
      t.references :assignment, index: true, foreign_key: true
      t.string :hw

      t.timestamps null: false
    end
  end
end
