class Admin::UsersController < Admin::BaseController
  before_action :require_super_admin!
  before_action :set_user, only: [ :edit, :update, :destroy ]

  def index
    @users = User.order(created_at: :desc)
  end

  def new
    @user = User.new(role: :content_editor)
  end

  def edit; end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: "User created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    attrs = user_params.to_h
    if attrs["password"].blank?
      attrs.delete("password")
      attrs.delete("password_confirmation")
    end

    if @user == current_user && attrs["role"].present? && attrs["role"] != "super_admin"
      redirect_to edit_admin_user_path(@user), alert: "You cannot downgrade your own Super Admin role."
      return
    end

    if @user.update(attrs)
      redirect_to admin_users_path, notice: "User updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @user == current_user
      redirect_to admin_users_path, alert: "You cannot delete your own account."
      return
    end
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted.", status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :role, :password, :password_confirmation)
  end
end
