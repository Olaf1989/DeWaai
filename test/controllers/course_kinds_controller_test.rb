require 'test_helper'

class CourseKindsControllerTest < ActionController::TestCase
  setup do
    @course_kind = course_kinds(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_kinds)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_kind" do
    assert_difference('CourseKind.count') do
      post :create, course_kind: { name: @course_kind.name, price: @course_kind.price }
    end

    assert_redirected_to course_kind_path(assigns(:course_kind))
  end

  test "should show course_kind" do
    get :show, id: @course_kind
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_kind
    assert_response :success
  end

  test "should update course_kind" do
    patch :update, id: @course_kind, course_kind: { name: @course_kind.name, price: @course_kind.price }
    assert_redirected_to course_kind_path(assigns(:course_kind))
  end

  test "should destroy course_kind" do
    assert_difference('CourseKind.count', -1) do
      delete :destroy, id: @course_kind
    end

    assert_redirected_to course_kinds_path
  end
end
