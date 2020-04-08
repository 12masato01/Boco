class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update,]

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = "投稿が保存されました"
      redirect_to questions_path, method: :index
    else
      flash[:danger] = "投稿に失敗しました"
      redirect_to new_question_path
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:success] = "投稿を更新しました" 
       redirect_to @question
    else
      render "edit"
    end
  end

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end

  def destroy
    @question = Question.find(params[:id])
    if current_user.admin? || current_user?(@question.user)
      flash[:success] = "投稿が削除されました" if @question.destroy
    else
      flash[:danger] = "投稿の削除に失敗しました"
    end
    redirect_to questions_path, method: :index
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

  def after_update_path_for(resource)
    question_path(resource)
  end

  def correct_user
    @question = Question.find(params[:id])
    redirect_to(root_url) unless @question.user == current_user
    flash[:danger] = "権限がありません"
  end
end
