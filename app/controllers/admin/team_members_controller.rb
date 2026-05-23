class Admin::TeamMembersController < Admin::BaseController
  before_action :set_team_member, only: [:show, :edit, :update, :destroy]

  def index
    @team_members = TeamMember.order(:name)
  end

  def show; end

  def new
    @team_member = TeamMember.new
  end

  def create
    @team_member = TeamMember.new(team_member_params)
    if @team_member.save
      redirect_to admin_team_members_path, notice: "Team member created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @team_member.update(team_member_params)
      redirect_to admin_team_members_path, notice: "Team member updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @team_member.destroy
    redirect_to admin_team_members_path, notice: "Team member deleted.", status: :see_other
  end

  private

  def set_team_member
    @team_member = TeamMember.find(params[:id])
  end

  def team_member_params
    params.require(:team_member).permit(:name, :position, :bio, :image, :email, :phone, :linkedin, :twitter, :facebook)
  end
end
