Rails.application.routes.draw do
  resources :taggings
  resources :tasks
  resources :tags
  match '/tasks/complete/:id' => 'tasks#complete', as: 'complete_task', via: :get
  root to: 'welcome#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
