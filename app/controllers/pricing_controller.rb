class PricingController < ApplicationController
  before_action :authenticate_user!, only: [:checkout]

  def index
    @plans = Plan.all
  end

  def checkout
    @plan = Plan.find(params[:plan_id])
    
    begin
      @checkout_session = create_stripe_checkout_session(@plan)
      redirect_to @checkout_session.url, allow_other_host: true
    rescue Stripe::StripeError => e
      Rails.logger.error("Stripe error: #{e.message}")
      flash[:alert] = "Unable to initiate payment: #{e.message}"
      redirect_to pricing_path
    end
  end

  private

  def create_stripe_checkout_session(plan)
    Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      customer_email: current_user.email,
      client_reference_id: current_user.id,
      line_items: [{
        price_data: {
          currency: 'gbp',
          product_data: {
            name: plan.name,
            description: plan.description,
          },
          unit_amount: (plan.price * 100).to_i,
        },
        quantity: 1,
      }],
      mode: 'payment',
      success_url: "#{root_url}checkout/success?session_id={CHECKOUT_SESSION_ID}",
      cancel_url: "#{root_url}pricing",
    )
  end
end
