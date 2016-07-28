class AddAssignments < ActiveRecord::Migration
  def change
    create_table "assignments", force: :cascade do |t|
      t.string :title
      t.text :content
      t.string :author
      t.string :released, default: "0"
      t.integer :assignment_number, numericality: true

      t.references :user, index: true

      t.timestamps null: false
    end
  end

end
