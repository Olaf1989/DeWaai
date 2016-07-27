class UsersController < ApplicationController
  # Before there is logged in (no current_user)
  skip_before_action :require_login, only: [:new, :create]

  # After there is logged in (current_user)
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # Load abilities from ability.rb
  load_and_authorize_resource

  # GET /users
  # GET /users.json
  def index
    @filterrific = initialize_filterrific(
        User,
        params[:filterrific],
        select_options: {
          sorted_by: User.options_for_sorted_by,
          with_created_at_gte: User.options_for_select,
          with_created_at_lte: User.options_for_select,
        },
      ) or return
        @users = @filterrific.find.page(params[:page])

        respond_to do |format|
        format.html
        format.js
      end

    # Recover from invalid param sets, e.g., when a filter refers to the
    # database id of a record that doesn’t exist any more.
    # In this case we reset filterrific and discard all filter params.
    rescue ActiveRecord::RecordNotFound => e
      # There is an issue with the persisted param_set. Reset it.
      puts "Had to reset filterrific params: #{ e.message }"
      redirect_to(reset_filterrific_url(format: :html)) and return
    end

  def employees
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to :root, notice: 'Gebruiker is succesvol aangemaakt.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'Gebruiker is succesvol gewijzigd.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'Gebruiker is succesvol verwijderd.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :firstname, :surenamePrefix, :surename, :birthdate, :address, :zipcode, :city, :telephone, :role_ids)
    end
end
