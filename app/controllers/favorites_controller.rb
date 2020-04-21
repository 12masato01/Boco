class FavoritesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question

  def create
    @favorite = current_user.favorites.build(favorite_params)
    if @favorite.save
      respond_to :js
    end
  end

  def destroy
    @favorite = Favorite.find(params[:id])
    if @like.destroy
      respond_to :js
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