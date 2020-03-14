# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    registrations: 'admins/registrations'
  }
  devise_for :users, controllers: {
    sessions:      'users/sessions',
    registrations: 'users/registrations'
  }

  devise_for :experts, controllers: {
    sessions:      'experts/sessions',
    passwords:     'experts/passwords',
    registrations: 'experts/registrations'
  }
  root 'top#home'
end
