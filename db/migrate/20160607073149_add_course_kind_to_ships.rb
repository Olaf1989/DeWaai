class AddCourseKindToShips < ActiveRecord::Migration
  def change
    add_column :ships, :course_kind_id, :integer
    add_index  :ships, :course_kind_id
  end
end
