class FaqsController < ApplicationController
  def index
    @faqs = Faq.where(published: true).order(position: :asc)
    @grouped_faqs = @faqs.group_by(&:category)
  end
end
