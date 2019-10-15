class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])

    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @post.save!
    redirect_to root_path
  end

  def edit
    if current_user == Post.find(params[:id]).user
      @post = Post.find(params[:id])
    end
  end

  def update
    if current_user == Post.find(params[:id]).user
      @post = Post.find(params[:id])
      @post.update!(post_params)
      redirect_to root_path
    end
  end

  def destroy
    if current_user == Post.find(params[:id]).user
      @post = Post.find(params[:id])
      @post.destroy!
      redirect_to root_path
    end
  end

  def user_posts
    @posts = current_user.posts
  end

  private

  def post_params # only for when you create new things
    params.require(:post).permit(:expression, :reading, :meaning, :content, :photo)
  end
end


