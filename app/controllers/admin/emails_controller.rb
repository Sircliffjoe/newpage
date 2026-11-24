class Admin::EmailsController < Admin::BaseController
  before_action :set_email, only: [:show]

  def index
    @pagy, @emails = pagy(:offset, Email.includes(:sent_by).recent, limit: 20)
    @stats = {
      total: Email.count,
      sent: Email.sent.count,
      failed: Email.failed.count
    }
  end

  def show; end

  def new
    @email = Email.new(
      recipient_email: params[:to],
      subject: params[:subject],
      contact_type: params[:contact_type].presence || "manual"
    )
    @prefilled_recipients = params[:to].presence || ""
    @contact_types = Email.contact_types.keys
    @lead_emails = Lead.where.not(email: [nil, ""]).distinct.pluck(:name, :email)
    @contact_emails = ContactSubmission.where.not(email: [nil, ""]).distinct.pluck(:name, :email)
    @subscriber_emails = NewsletterSubscriber.active.distinct.pluck(:email)
    @visa_lead_emails = Lead.where(service_type: :visa).where.not(email: [nil, ""]).distinct.pluck(:name, :email)
    @study_lead_emails = Lead.where(service_type: :study_abroad).where.not(email: [nil, ""]).distinct.pluck(:name, :email)
  end

  def create
    recipients = parse_recipients(params.dig(:email, :recipients))
    contact_type = params.dig(:email, :contact_type).presence || "manual"
    subject = params.dig(:email, :subject).to_s.strip
    body = params.dig(:email, :body).to_s.strip

    if recipients.empty? || subject.blank? || body.blank?
      redirect_to new_admin_email_path, alert: "Please provide at least one valid recipient, a subject, and a message body."
      return
    end

    sent_count = 0
    failed_count = 0

    recipients.each do |recipient|
      email_record = Email.create!(
        recipient_email: recipient[:email],
        recipient_name: recipient[:name],
        subject: subject,
        body: body,
        contact_type: Email.contact_types.key?(contact_type) ? contact_type : "manual",
        status: "pending",
        sent_by: current_user
      )

      result = BrevoMailerService.send_email(
        to_email: email_record.recipient_email,
        to_name: email_record.recipient_name,
        subject: email_record.subject,
        text_content: email_record.body
      )

      if result.success?
        email_record.update!(status: "sent", provider_message_id: result.message_id, sent_at: Time.current)
        sent_count += 1
      else
        email_record.update!(status: "failed", error_message: result.error)
        failed_count += 1
      end
    end

    if failed_count.zero?
      redirect_to admin_emails_path, notice: "Successfully sent #{sent_count} email(s) via Brevo."
    else
      redirect_to admin_emails_path, alert: "Sent #{sent_count} email(s), #{failed_count} failed. Check delivery logs for details."
    end
  end

  private

  def set_email
    @email = Email.find(params[:id])
  end

  def parse_recipients(raw_input)
    return [] if raw_input.blank?

    seen = Set.new
    raw_input.split(/[\r\n,]+/).each_with_object([]) do |entry, list|
      line = entry.strip
      next if line.blank?

      if line =~ /\A(.*)<([^>]+)>\z/
        name = Regexp.last_match(1).strip
        email = Regexp.last_match(2).strip.downcase
      else
        name = nil
        email = line.downcase
      end

      next unless email.match?(URI::MailTo::EMAIL_REGEXP)
      next if seen.include?(email)

      seen.add(email)
      list << { email: email, name: name.presence || email }
    end
  end
end
