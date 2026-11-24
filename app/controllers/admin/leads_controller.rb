require "csv"

class Admin::LeadsController < Admin::BaseController
  before_action :set_lead, only: [ :show, :edit, :update, :destroy ]

  def index
    @leads = Lead.includes(:assigned_to).order(created_at: :desc)
    @leads = @leads.where(status: params[:status]) if params[:status].present? && Lead.statuses.key?(params[:status])
    @leads = @leads.where(service_type: params[:service_type]) if params[:service_type].present? && Lead.service_types.key?(params[:service_type])
    if params[:q].present?
      pattern = "%#{ActiveRecord::Base.sanitize_sql_like(params[:q].strip)}%"
      @leads = @leads.where("name ILIKE ? OR email ILIKE ? OR phone ILIKE ?", pattern, pattern, pattern)
    end
  end

  def show
    @notes = @lead.notes.includes(:author).order(created_at: :desc)
    @note = Note.new
  end

  def edit; end

  def update
    if @lead.update(lead_params)
      redirect_to admin_lead_path(@lead), notice: "Lead updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @lead.destroy
    redirect_to admin_leads_path, notice: "Lead deleted.", status: :see_other
  end

  def export
    leads = Lead.order(created_at: :desc)
    csv_data = CSV.generate(headers: true) do |csv|
      csv << [ "ID", "Name", "Email", "Phone", "Service Type", "Status", "Source", "Message", "Created At" ]
      leads.each do |lead|
        csv << [
          lead.id,
          sanitize_csv_cell(lead.name),
          sanitize_csv_cell(lead.email),
          sanitize_csv_cell(lead.phone),
          lead.service_type,
          lead.status,
          sanitize_csv_cell(lead.source),
          sanitize_csv_cell(lead.message),
          lead.created_at.iso8601
        ]
      end
    end

    send_data csv_data, filename: "newpage-leads-#{Date.current}.csv", type: "text/csv"
  end

  private

  def sanitize_csv_cell(value)
    str = value.to_s
    str.match?(/\A[=+\-@\t\r]/) ? "'#{str}" : str
  end

  def set_lead
    @lead = Lead.find(params[:id])
  end

  def lead_params
    params.require(:lead).permit(:status, :service_type, :notes, :assigned_to_id)
  end
end
