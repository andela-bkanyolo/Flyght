Rails.application.routes.draw do

  root 'flights#home'
  get "manage" => "bookings#manage"

  resources :flights, only: [:index]
  resources :bookings, only: [:new, :create, :show, :edit, :update, :destroy]
end
