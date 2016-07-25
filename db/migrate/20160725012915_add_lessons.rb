class AddLessons < ActiveRecord::Migration
  def change
    create_table "lessons", force: :cascade do |t|
      t.string :title
      t.text :content
      t.string :author
      t.string :released, default: "0"

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
