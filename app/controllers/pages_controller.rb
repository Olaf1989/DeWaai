class PagesController < ApplicationController
  # Before there is logged in (no current_user)
  skip_before_action :require_login, only: [:index, :about, :contact]

  def index
  end

  def about
  end

  def contact
  end
end
