class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :question_set, only: [:edit, :update, :show, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]

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

  def edit; end

  def update
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

  def show; end

  def destroy
    flash[:success] = "投稿が削除されました" if @question.destroy
    redirect_to questions_path, method: :index
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

  def after_update_path_for(resource)
    question_path(resource)
  end

  def question_set
    @question = Question.find(params[:id])
  end

  def correct_user
    if !@question.user == current_user
    redirect_to(root_url) 
    flash[:danger] = "権限がありません" 
    end
  end
end
