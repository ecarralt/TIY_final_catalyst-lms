class AddProgressReports < ActiveRecord::Migration
  def change

    create_table "progressreports", force: :cascade do |t|
      t.string :title
      t.string :progress_score
      t.text :instructor_feedback

      t.integer :total_lessons
      t.integer :completed_lessons

      t.integer :total_assignments
      t.integer :completed_assignments

      t.integer :student_id
      t.string :student_name

      t.integer :pr_number

      t.references :user, index: true

      t.timestamps null: false
    end
  end
end
