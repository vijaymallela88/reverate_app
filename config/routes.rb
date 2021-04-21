Rails.application.routes.draw do
  get 'posts/index'
  get 'posts/new'
  get 'posts/edit'
  get 'posts/show'
  # devise_for :users
  resources :posts
  devise_for :users, controllers: {
        sessions: 'users/sessions'
      }
	root to: "posts#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
