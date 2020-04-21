class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @favorite = current_user.favorites.build(question_params)
    @question = @favorite.question
    @favorite.save!
    flash[:success] = '気になっている質問に登録しました'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @favorite = current_user.favorites.find_by(question_params)
    @favorite.destroy!
    flash[:success] = '気になっている質問から削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def question_params
    params.permit(:question_id)
  end
end
