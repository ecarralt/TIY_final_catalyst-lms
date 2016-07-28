class AddAssignmentRecords < ActiveRecord::Migration
  def change
    create_table "assignmentrecords", force: :cascade do |t|
      t.text :comments
      t.string :url_link
      t.string :score
      t.text :instructor_feedback
      t.string :graded_by

      t.references :user, index: true
      t.references :assignment, index: true

      t.timestamps null: false
    end
  end
end
