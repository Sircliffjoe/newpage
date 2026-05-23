class Admin::ContactSubmissionsController < Admin::BaseController
  before_action :set_contact_submission, only: [:show, :destroy]

  def index
    @contact_submissions = ContactSubmission.order(created_at: :desc)
  end

  def show; end

  def destroy
    @contact_submission.destroy
    redirect_to admin_contact_submissions_path, notice: "Contact submission deleted.", status: :see_other
  end

  private

  def set_contact_submission
    @contact_submission = ContactSubmission.find(params[:id])
  end

  def contact_submission_params
    params.require(:contact_submission).permit(:name, :email, :phone, :subject, :message, :service_interest)
  end
end
