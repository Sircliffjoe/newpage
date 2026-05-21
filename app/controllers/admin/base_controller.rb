class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  layout "admin"

  private

  def require_admin!
    unless current_user&.super_admin? || current_user&.content_editor?
      redirect_to root_path, alert: "You are not authorized to access this area."
    end
  end
end
