class CreateCourseKinds < ActiveRecord::Migration
  def change
    create_table :course_kinds do |t|
      t.string :name
      t.decimal :price

      t.timestamps null: false
    end
  end
end
