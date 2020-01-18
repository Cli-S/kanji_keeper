Rails.application.routes.draw do
  get 'rooms/show'
  #get '/faq', to: 'static_pages#faq'
  get '/contact', to: 'static_pages#contact'
  #get '/about', to: 'static_pages#about'
  devise_for :users, controllers: { sessions: "users/sessions" }
  root 'posts#index'
  #root 'chat_rooms#index'
  #root :to => 'chat_rooms#show', :id => '36', as: 'chat'
  get 'chat' => 'chat_rooms#show', :defaults => {:id => 3}
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
    resources :favorites, only: [:create, :show, :destroy]
  end
  resources :favorites, only: [:index]
  #resources :chat_rooms, only: [:new, :create, :show, :index] do
    #resources :chat_room_users, only: [:create]
  #end
  resources :chat_rooms do
    resource :chat_room_users
    resources :messages
  end
  get '/user/:id/posts', to: 'posts#user_posts', as: 'user_posts'

  mount ActionCable.server, at: '/cable'
=begin 
  (same thing as nested routes)
    resources :posts
    post 'posts/:post_id/comment', to: 'comments#create', as: 'post_comments'
    post 'posts/:post_id/favorite', to: 'favorites#create', as: 'post_favorites'
=end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
