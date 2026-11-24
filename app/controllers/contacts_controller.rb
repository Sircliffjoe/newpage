class ContactsController < ApplicationController
  def new
    @page = PageSetting.for("contact")
    apply_page_meta_tags("contact", fallback_title: "Contact Us")
    @contact_submission = ContactSubmission.new(subject: params[:subject])
  end

  def create
    @contact_submission = ContactSubmission.new(contact_params)

    if @contact_submission.save
      service_type = infer_service_type(@contact_submission.subject, params[:service_type])

      Lead.create(
        name: @contact_submission.name,
        email: @contact_submission.email,
        phone: @contact_submission.phone,
        message: @contact_submission.message,
        service_type: service_type,
        source: params[:source].presence || "contact_form"
      )

      begin
        InquiryMailer.client_confirmation(@contact_submission).deliver_later
        InquiryMailer.admin_notification(@contact_submission).deliver_later
      rescue StandardError => e
        Rails.logger.error("[ContactsController] Mailer error: #{e.message}")
      end

      redirect_back fallback_location: contact_path,
                    notice: "Thank you! Your message has been received. A consultant will reach out within 24 hours."
    else
      @page = PageSetting.for("contact")
      render :new, status: :unprocessable_entity
    end
  end

  private

  def contact_params
    params.require(:contact_submission).permit(:name, :email, :phone, :subject, :message)
  end

  def infer_service_type(subject, explicit_type)
    return explicit_type if explicit_type.present? && Lead.service_types.key?(explicit_type.to_s)

    text = subject.to_s.downcase
    return :visa if text.include?("visa")
    return :study_abroad if text.include?("study") || text.include?("admission")
    return :cac if text.include?("cac") || text.include?("business") || text.include?("ngo") || text.include?("scuml")
    return :travel if text.include?("flight") || text.include?("tour") || text.include?("hotel") || text.include?("travel")

    :general
  end
end
