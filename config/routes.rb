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

  devise_for :experts, controllers: {
    sessions: "experts/sessions",
  }
  namespace :experts do
    resources :questions, only: %i(index show)
    resources :answers, except: :new
  end
  get  "experts/answers/new/:id", to: "experts/answers#new", as: "new_experts_answer"

  devise_for :users, controllers: {
    sessions:      "users/sessions",
    registrations: "users/registrations",
  }
  namespace :users do
    resources :questions
    get  "/user_question", to: "questions#user_question"
  end
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
  end
end
