class Admins::UsersController < ApplicationController
  before_action :authenticate_admin!

  def index
    @users = User.all
  end

  def destroy
    @user = User.find(params[:id])
    flash[:success] = "ユーザーが削除されました" if @user.destroy
    redirect_to admins_users_path
  end
end