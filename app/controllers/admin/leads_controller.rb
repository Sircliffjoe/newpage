class Admin::LeadsController < Admin::BaseController
  before_action :set_lead, only: [:show, :edit, :update, :destroy]

  def index
    @leads = Lead.order(created_at: :desc)
  end

  def show; end

  def edit; end

  def update
    if @lead.update(lead_params)
      redirect_to admin_lead_path(@lead), notice: "Lead updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lead.destroy
    redirect_to admin_leads_path, notice: "Lead deleted.", status: :see_other
  end

  private

  def set_lead
    @lead = Lead.find(params[:id])
  end

  def lead_params
    params.require(:lead).permit(:status, :notes, :assigned_to_id)
  end
end
