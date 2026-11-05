Rails.application.routes.draw do
  devise_for :users, skip: :registrations

  root "static_pages#top"

  resources :daily_reports, only: %i[index show new create edit update] do
    patch :toggle_attention, on: :member
  end

  resource :calendar, only: :show

  namespace :my do
    resources :daily_reports, only: :index
  end

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
