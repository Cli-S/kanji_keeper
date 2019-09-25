class FavoritesController < ApplicationController
  before_action :find_post
  before_action :find_favorite, only: [:destroy]

  def create
    if !already_favorited? 
      @post.favorites.create(user_id: current_user.id)
    end
    redirect_to post_path(@post)
  end

  def destroy
    if already_favorited?
      @favorite.destroy
    end
    redirect_to post_path(@post)
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
