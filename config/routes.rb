Rails.application.routes.draw do
  get '/faq', to: 'static_pages#faq'
  get '/about', to: 'static_pages#about'
  devise_for :users
  root 'posts#index'
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :favorites, only: [:create, :show, :destroy]
  end
  resources :favorites, only: [:index]
  get '/user/:id/posts', to: 'posts#user_posts', as: 'user_posts'
=begin 
  (same thing as nested routes)
    resources :posts
    post 'posts/:post_id/comment', to: 'comments#create', as: 'post_comments'
    post 'posts/:post_id/favorite', to: 'favorites#create', as: 'post_favorites'
=end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
