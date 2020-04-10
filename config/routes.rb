# frozen_string_literal: true

Rails.application.routes.draw do
  root "top#home"

  devise_for :admins, controllers: {
    sessions: "admins/sessions",
  }
  namespace :admins do
    resources :users, only: %i(index destroy)
    resources :questions, only: %i(index destroy)
  end

  devise_for :users, controllers: {
    sessions:      "users/sessions",
    registrations: "users/registrations",
  }
  resources :questions
  resources :answers
  get  "/user_question", to: "questions#user_question"
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
end
