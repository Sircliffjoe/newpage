class Admin::NotesController < Admin::BaseController
  before_action :set_lead

  def create
    @note = @lead.notes.build(note_params)
    @note.author = current_user

    if @note.save
      redirect_to admin_lead_path(@lead), notice: "Note added."
    else
      redirect_to admin_lead_path(@lead), alert: "Note cannot be blank."
    end
  end

  def destroy
    @note = @lead.notes.find(params[:id])
    @note.destroy
    redirect_to admin_lead_path(@lead), notice: "Note removed.", status: :see_other
  end

  private

  def set_lead
    @lead = Lead.find(params[:lead_id])
  end

  def note_params
    params.require(:note).permit(:body)
  end
end
