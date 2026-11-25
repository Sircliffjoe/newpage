class Admin::AwardsController < Admin::BaseController
  before_action :require_content_editor!
  before_action :set_award, only: [ :edit, :update, :destroy ]

  def index
    @awards = Award.ordered
  end

  def new
    @award = Award.new(
      published: true,
      recipient_name: "NewPage Integrity Travels & Tours Limited"
    )
  end

  def edit; end

  def create
    @award = Award.new(award_params)
    if @award.save
      redirect_to admin_awards_path, notice: "Award created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @award.update(award_params)
      redirect_to admin_awards_path, notice: "Award updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @award.destroy
    redirect_to admin_awards_path, notice: "Award deleted.", status: :see_other
  end

  private

  def set_award
    @award = Award.find(params[:id])
  end

  def award_params
    params.require(:award).permit(
      :title, :recipient_type, :recipient_name, :issuing_organization,
      :awarded_on, :location, :category, :description,
      :image, :position, :published, :featured
    )
  end
end
