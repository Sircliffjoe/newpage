class ContactsController < ApplicationController
  def new
    @contact_submission = ContactSubmission.new
  end

  def create
    @contact_submission = ContactSubmission.new(contact_params)

    if @contact_submission.save
      # Also create a lead from the contact form
      Lead.create(
        name: @contact_submission.name,
        email: @contact_submission.email,
        phone: @contact_submission.phone,
        message: @contact_submission.message,
        service_type: :general,
        source: "contact_form"
      )
      redirect_to contact_path, notice: "Thank you! Your message has been sent successfully. We'll be in touch within 24 hours."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact_submission).permit(:name, :email, :phone, :subject, :message)
  end
end
