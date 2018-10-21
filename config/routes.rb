Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html  
  resources :users
  resources :customers
  resources :projects
  resources :tasks
  resources :task_entries
end

