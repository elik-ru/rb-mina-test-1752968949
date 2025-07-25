Rails.application.routes.draw do
  devise_for :users,
             path_names: {:sign_in => 'login', :sign_out => 'logout', :sign_up => 'register'},
             controllers: {
               registrations: "registrations",
               omniauth_callbacks: "users/omniauth_callbacks"
             }

  root 'static_pages#home'

  get '/faq', to: 'static_pages#faq', as: :faq
  get '/health', to: 'health#show'

  draw(:admin)

  resources :posts, path: :blog
  resources :users, only: [:show]
  
  get "/feature-flags-demo", to: "feature_flags_demo#index", as: :feature_flags_demo

  get "/profile", to: "users#show", as: :profile
  get "/profile/edit", to: "users#edit", as: :edit_profile
  get "/profile/edit_avatar", to: "users#edit_avatar", as: :edit_avatar
  patch "/profile/update_avatar", to: "users#update_avatar", as: :update_avatar
  patch "/profile/edit", to: "users#update"
  post "/profile/password", to: "users#password", as: :update_password
  post "/profile/disavow",  to: "users#disavow", as: :disavow
  post "/profile/cancel_email_change", to: "users#cancel_email_change", as: :cancel_email_change
  post "/profile/resend_confirmation_email", to: "users#resend_confirmation_email", as: :resend_confirmation_email
  get "/profile/subscriptions", to: "subscriptions#index", as: :my_subscriptions
  post "/profile/subscriptions/cancel", to: "subscriptions#cancel_subscription", as: :cancel_subscription
  post "/profile/subscriptions/renew", to: "subscriptions#renew", as: :renew_subscription
  get "/profile/subscriptions/invoices", to: "subscriptions#invoices", as: :invoices_subscription

  get "/contacts", to: "contacts#new"
  post "/contacts", to: "contacts#create"

  get "/subscribe", to: "subscriptions#new", as: :subscribe_index
  get "/subscribe/success", to: "subscriptions#successful", as: :subscribe_success
  get "/subscribe/cancel", to: "subscriptions#cancel", as: :subscribe_cancel
  get "/subscribe/:reference", to: "subscriptions#subscribe", as: :subscribe
  post "/subscribe/:reference", to: "subscriptions#do_subscribe", as: :subscribe_submit

  post "/stripe", to: "stripe#webhook"


  %w(404 422 500).each do |code|
    get code, to: 'errors#show', code: code
  end

  get "/*path", to: 'static_pages#page', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
