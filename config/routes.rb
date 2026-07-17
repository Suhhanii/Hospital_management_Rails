Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # resources :patients do
  #   collection do
  #     get :dashboard
  #   end
  # end
  # resources :doctors
  # resources :appointments
  # resources :specializations

  root "dashboard#index"

  resources :users
  resources :appointments

  get  "signin",  to: "authentication#new"

  post "signin",  to: "authentication#create"

  delete "signout", to: "authentication#destroy"

  get "dashboard", to: "dashboard#user_show"
  # get "/dashboard", to: "users#dashboard"

  # # get "dashboard", to: "dashboard#index"

  # get "patient/login", to: "patient_sessions#new", as: :new_patient_login
  # post "/patient/login", to: "patient_sessions#create", as: :patient_login
  # delete "patient/logout", to: "patient_sessions#destroy", as: :patient_logout

  # get "doctor/login", to: "doctor_sessions#new", as: :new_doctor_login
  # post "doctor/login", to: "doctor_sessions#create", as: :doctor_login
  # delete "doctor/logout", to: "doctor_sessions#destroy", as: :doctor_logout
end
