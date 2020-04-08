# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: "admins/sessions",
  }
  namespace :admins do
    resources :users, only: %i(index destroy)
    resources :questions, only: %i(index destroy)
  end

  devise_for :experts, controllers: {
    sessions: "experts/sessions",
  }
  namespace :experts do
    resources :questions, only: %i(index show)
    resources :answers
  end

  devise_for :users, controllers: {
    sessions:      "users/sessions",
    registrations: "users/registrations",
  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end

  root "top#home"
  get  "/user_question", to: "top#user_question"
  resources :questions

end
