class AnswersController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]
  before_action :answer_set, only: %i[edit update show destroy]
  before_action :correct_user, only: %i[edit update destroy]

  def new
    @question = Question.find(params[:id])
    @answer = @question.answers.build
  end

  def create
    @answer = current_user.answers.build(answer_params)
    if @answer.save
      flash[:success] = '回答が保存されました'
      redirect_to question_path(@answer.question)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      flash[:success] = '回答を更新しました'
      redirect_to question_path(@answer.question)
    else
      render 'edit'
    end
  end

  def index
    @answers = Answer.all
  end

  def show; end

  def destroy
    if @answer.destroy
      flash[:success] = '回答が削除されました'
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = '権限がありません'
      redirect_to root_url
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:title, :content, :question_id, :image)
  end

  def answer_set
    @answer = Answer.find(params[:id])
  end

  def correct_user
    @answer = current_user.answers.find_by(id: params[:id])
    return unless @answer.nil?

    redirect_to root_path
    flash[:danger] = '権限がありません'
  end
end
