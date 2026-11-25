class AwardsController < ApplicationController
  def index
    @page = PageSetting.for("awards")
    apply_page_meta_tags("awards", fallback_title: "Awards & Recognition")

    @total_count = Award.published.count
    @company_count = Award.published.company.count
    @founder_count = Award.published.founder.count

    @active_recipient = params[:recipient_type].presence if Award.recipient_types.key?(params[:recipient_type].to_s)
    @awards = Award.published.ordered
    @awards = @awards.where(recipient_type: @active_recipient) if @active_recipient.present?
  end
end
