Rails.application.routes.draw do
  mount Liveness::Status => '/status'

  namespace :admin do
    resources :blogs
    resources :communities
    resources :events
  end

  resources :blogs, only: :show
  # mount Fae below your admin namespec
  mount Fae::Engine => '/admin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "home#landing"
end
