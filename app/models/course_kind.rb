class CourseKind < ActiveRecord::Base
  has_many :courses
  has_many :ships
end
