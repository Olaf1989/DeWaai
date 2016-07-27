class UserCoursesController < ApplicationController

  def new
    @course = Course.find params[:course_id]
    @user_course = User_course.new({course: course})
  end

  def create
    @course = Course.find params[:course_id]
    @user_course = current_user.user_courses.build(course: @course)
    @existing_course_user = UserCourse.where course: @course.id, user: current_user.id
    if @existing_course_user.exists? # If relation allready exists
      if @existing_course_user.destroy_all # Destroy_all connections
        flash[:notice] = "U bent afgemeld voor de cursus."
        redirect_to :back
      else
        flash[:notice] = "Afmelden niet gelukt."
        redirect_to :back
      end
    else # If the relation doesn't exists
      if @user_course.save
        flash[:notice] = "U bent aangemeld voor de cursus."
        redirect_to :back
      else
        flash[:error] = "Aanmelden niet gelukt."
        redirect_to :back
      end
    end
  end

  private
  def user_course_params
      params.require(:user_courses).permit(:course_id)
  end
end
