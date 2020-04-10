class AnswersController < ApplicationController
  before_action :authenticate_expert! 
  before_action :answer_set, only: [:edit, :update, :show, :destroy]
  before_action :correct_expert, only: [:edit, :update, :destroy]

  def new
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def create
    @answer = current_user.answers.build(answer_params)
    if @answer.save
      flash[:success] = "投稿が保存されました"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = "投稿に失敗しました"
      render "new"
    end
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      flash[:success] = "投稿を更新しました" 
       redirect_to experts_answers_path
    else
      render "edit"
    end
  end

  def index
    @answers = Answer.all
  end

  def show; end

  def destroy
    flash[:success] = "投稿が削除されました" if @answer.destroy
    redirect_to experts_answers_path, method: :get
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :content)
  end

  def after_update_path_for(resource)
    question_path(resource)
  end

  def answer_set
    @answer = Answer.find(params[:id])
  end

  def correct_expert
    if !@answer.expert == current_expert
    redirect_to(root_url) 
    flash[:danger] = "権限がありません" 
    end
  end
end