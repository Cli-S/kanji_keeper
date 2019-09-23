Rails.application.routes.draw do
  devise_for :users
  root 'posts#index'
  resources :posts
  post 'posts/:post_id/comment', to: 'comments#create', as: 'post_comments'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
