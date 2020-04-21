class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def create
    @favorite = current_user.favorites.build(favorite_params)
      @favorite.save!
      flash[:success] = '気になっている質問に登録しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
      @favorite.destroy!
      flash[:success] = '気になっている質問から削除しました。'
      redirect_back(fallback_location: root_path)
    end
  end

  private
    def favorite_params
      params.permit(:question_id)
    end

    def set_question
      @question = @favorite.question
    end
end
