class InquiryMailer < ApplicationMailer
  default from: -> { ENV.fetch("BREVO_SENDER_EMAIL", "info@newpageintegritytravels.com") }

  def client_confirmation(contact_submission)
    @submission = contact_submission
    mail(
      to: @submission.email,
      subject: "We received your inquiry — NewPage Integrity Travels"
    )
  end

  def admin_notification(contact_submission)
    @submission = contact_submission
    admin_email = ENV.fetch("ADMIN_NOTIFICATION_EMAIL", "newpageintegritytravels@gmail.com")
    mail(
      to: admin_email,
      reply_to: @submission.email,
      subject: "[NewPage Inquiry] #{@submission.subject.presence || 'New Consultation Request'} from #{@submission.name}"
    )
  end
end
