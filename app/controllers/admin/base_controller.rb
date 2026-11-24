class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!
  layout "admin"

  private

  def require_admin!
    unless current_user&.super_admin? || current_user&.content_editor? || current_user&.staff?
      redirect_to root_path, alert: "You are not authorized to access this area."
    end
  end

  def require_content_editor!
    unless current_user&.super_admin? || current_user&.content_editor?
      redirect_to admin_root_path, alert: "You need Content Editor or Super Admin access for this section."
    end
  end

  def require_super_admin!
    unless current_user&.super_admin?
      redirect_to admin_root_path, alert: "Only Super Admins can access this section."
    end
  end
end
