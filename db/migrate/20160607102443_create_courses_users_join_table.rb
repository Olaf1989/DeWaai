class CreateCoursesUsersJoinTable < ActiveRecord::Migration
  def self.up
    create_table :user_courses do |t|
    t.references :course, null: false
    t.references :user, null: false
  end

  # Add an unique index for better join speed!
  add_index(:user_courses, [:user_id, :course_id], :unique => true)
  end
end
