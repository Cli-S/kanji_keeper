class FavoritesController < ApplicationController
  before_action :find_post, except: [:index]
  before_action :find_favorite, only: [:destroy]

  def index
    @posts = current_user.favorite_posts
  end

  def create
    if !already_favorited? 
      @post.favorites.create(user_id: current_user.id)
    end

    if params["redirect_to"].present?
      redirect_to params["redirect_to"]
    end
  end

  def destroy
    if already_favorited?
      @favorite.destroy
    end

    if params["redirect_to"].present?
      redirect_to params["redirect_to"]
    end
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_favorite
    @favorite = @post.favorites.find(params[:id])
  end

  def already_favorited?
    Favorite.where(user_id: current_user.id, post_id: params[:post_id]).exists?
  end
end
