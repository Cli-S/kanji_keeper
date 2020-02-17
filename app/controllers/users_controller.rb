class UsersController < ApplicationController
  def show
    #@user = User.find_by_username(params[:username])
    #@user = User.where(username: params[:username]).first or [0]
    @user = User.find_by(username: params[:username])
  end
end
