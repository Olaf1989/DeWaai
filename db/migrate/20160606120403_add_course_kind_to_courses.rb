class AddCourseKindToCourses < ActiveRecord::Migration
  def change
    add_reference :courses, :coursekind, index: true, foreign_key: true
  end
end
