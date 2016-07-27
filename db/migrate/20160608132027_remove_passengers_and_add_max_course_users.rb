class RemovePassengersAndAddMaxCourseUsers < ActiveRecord::Migration
  def change
    add_column :course_kinds, :maxusers, :integer
    remove_column :ships, :passengers
  end
end
