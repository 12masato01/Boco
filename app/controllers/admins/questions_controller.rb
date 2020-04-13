class Admins::QuestionsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @questions = Question.all
  end

  def destroy
    @question = Question.find(params[:id])
    flash[:success] = '投稿が削除されました'
    redirect_to admins_questions_path
  end
end
