class AddUsersTable < ActiveRecord::Migration
  def change

    create_table "users", force: :cascade do |t|

      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :username, unique: true
      t.string :password_digest, null: false
      t.string :photofile_id
      t.string :usertype
      t.timestamps null: false
    end
  end
end
