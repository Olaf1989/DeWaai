Rails.application.routes.draw do

  resources :users
  resources :user_sessions
  resources :ships
  resources :course_kinds
  resources :courses do
    resources :user_courses
  end

  # Root
  root 'pages#index'

  # Get
  get 'home' => 'pages#index', :as => :home
  get 'about' => 'pages#about', :as => :about
  get 'contact' => 'pages#contact', :as => :contact
  get 'damage' => 'ships#damage', :as => :damage
  get 'employees' => 'users#employees', :as => :employees
  get 'register' => 'users#new', :as => :register
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

end
