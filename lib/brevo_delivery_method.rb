class BrevoDeliveryMethod
  def initialize(settings = {})
    @settings = settings
  end

  def deliver!(mail)
    html_part = mail.html_part&.body&.decoded
    text_part = mail.text_part&.body&.decoded || (mail.multipart? ? nil : mail.body.decoded)

    Array(mail.to).each do |recipient|
      result = BrevoMailerService.send_email(
        to_email: recipient,
        subject: mail.subject.to_s,
        html_content: html_part,
        text_content: text_part,
        reply_to: Array(mail.reply_to).first
      )
      raise StandardError, result.error unless result.success?
    end
  end
end
