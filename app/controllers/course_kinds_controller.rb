class CourseKindsController < ApplicationController
  # After there is logged in (current_user)
  before_action :set_course_kind, only: [:show, :edit, :update, :destroy]

  # Load abilities from ability.rb
  load_and_authorize_resource

  # GET /course_kinds
  # GET /course_kinds.json
  def index
    @course_kinds = CourseKind.all
  end

  # GET /course_kinds/1
  # GET /course_kinds/1.json
  def show
  end

  # GET /course_kinds/new
  def new
    @course_kind = CourseKind.new
  end

  # GET /course_kinds/1/edit
  def edit
  end

  # POST /course_kinds
  # POST /course_kinds.json
  def create
    @course_kind = CourseKind.new(course_kind_params)

    respond_to do |format|
      if @course_kind.save
        format.html { redirect_to @course_kind, notice: 'Cursus soort is succesvol aangemaakt.' }
        format.json { render :show, status: :created, location: @course_kind }
      else
        format.html { render :new }
        format.json { render json: @course_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_kinds/1
  # PATCH/PUT /course_kinds/1.json
  def update
    respond_to do |format|
      if @course_kind.update(course_kind_params)
        format.html { redirect_to @course_kind, notice: 'Cursus soort is succesvol gewijzigd.' }
        format.json { render :show, status: :ok, location: @course_kind }
      else
        format.html { render :edit }
        format.json { render json: @course_kind.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_kinds/1
  # DELETE /course_kinds/1.json
  def destroy
    @course_kind.destroy
    respond_to do |format|
      format.html { redirect_to course_kinds_url, notice: 'Cursus soort is succesvol verwijderd.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_kind
      @course_kind = CourseKind.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_kind_params
      params.require(:course_kind).permit(:name, :price, :maxusers)
    end
end
