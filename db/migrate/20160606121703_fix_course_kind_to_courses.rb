class FixCourseKindToCourses < ActiveRecord::Migration
  def change
    remove_column :courses, :coursekind

    add_column :courses, :course_kind_id, :integer
    add_index  :courses, :course_kind_id
  end
end
