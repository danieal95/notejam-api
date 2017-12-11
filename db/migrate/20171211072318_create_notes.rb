class CreateNotes < ActiveRecord::Migration[5.1]
  def change
    create_table :notes do |t|
      t.references :pad, foreign_key: true
      t.references :user, foreign_key: true
      t.string :name
      t.text :text

      t.timestamps
    end
  end
end
