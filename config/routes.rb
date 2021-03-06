# frozen_string_literal: true

Rails.application.routes.draw do
  root "top#home"

  devise_for :admins, controllers: {
    sessions: "admins/sessions"
  }
  namespace :admins do
    resources :users, only: %i(index destroy)
    resources :questions, only: %i(index destroy)
  end

  devise_for :users, controllers: {
    sessions:      "users/sessions",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get "/users/sign_out" => "devise/sessions#destroy"
    #ゲストログイン機能
    post "users/guest_sign_in", to: "users/sessions#new_guest"
  end

  get  "/user_question", to: "questions#user_question" 
  get  "/user_favorite", to: "questions#user_favorite" 
  resources :questions do
    resources :comments, only: %i[create destroy], module: :questions
    resource :favorite, only: %i[create destroy]
  end

  get  "/answers/:id", to: "answers#new", as: :new_answer
  resources :answers, except: %i(new) do
    resources :comments, only: %i[create destroy], module: :answers
  end
end
