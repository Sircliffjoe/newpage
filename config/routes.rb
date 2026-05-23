Rails.application.routes.draw do
  devise_for :users
  
  root "pages#home"
  
  get "/about", to: "pages#about", as: :about
  get "/visa-information", to: "pages#visa_information", as: :visa_information
  get "/study-abroad", to: "pages#study_abroad", as: :study_abroad
  get "/cac-services", to: "pages#cac_services", as: :cac_services
  
  resources :services, only: [:index, :show], param: :slug
  resources :destinations, only: [:index, :show], param: :slug
  
  # Blog
  get "/blog", to: "blog_posts#index", as: :blog
  get "/blog/:slug", to: "blog_posts#show", as: :blog_post
  
  # Other pages
  get "/testimonials", to: "testimonials#index", as: :testimonials
  get "/gallery", to: "gallery#index", as: :gallery
  get "/faq", to: "faqs#index", as: :faqs
  
  # Contact
  get "/contact", to: "contacts#new", as: :contact
  post "/contact", to: "contacts#create"

  # Admin Dashboard
  namespace :admin do
    get "dashboard/index"
    root to: "dashboard#index"
    resources :services
    resources :destinations
    resources :blog_categories
    resources :blog_posts
    resources :testimonials
    resources :gallery_images
    resources :faqs
    resources :leads
    resources :team_members
    resources :contact_submissions, only: [:index, show, destroy]
    resources :newsletter_subscribers, only: [:index, destroy]
    resources :page_settings, only: [:index, edit, update]
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
