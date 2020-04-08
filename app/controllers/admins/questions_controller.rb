class Admins::QuestionsController < ApplicationController
before_action :authenticate_admin!

  def index
    @questions = Question.all
  end

  def destroy
    @question = Question.find(params[:id])
    flash[:success] = "投稿が削除されました" if @question.destroy
    redirect_to admins_questions_path
  end
end