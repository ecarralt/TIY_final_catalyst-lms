class AddLessonRecords < ActiveRecord::Migration
  def change

    create_table "lessonrecords", force: :cascade do |t|
      t.string :complete, default: "no"

      t.references :user, index: true
      t.references :lesson, index: true

      t.timestamps null: false
    end

  end
end
