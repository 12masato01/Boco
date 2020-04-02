class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.present?
      @question.save
      redirect_to root_path
      flash[:notice] = '投稿が保存されました'
    else
      redirect_to root_path
      flash[:alert] = '投稿に失敗しました'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to questions_path, method: :index
    else
      render 'edit'
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
    if @question.user == current_user
      flash[:notice] = '投稿が削除されました' if @question.destroy
    else
      flash[:alert] = '投稿の削除に失敗しました'
    end
    redirect_to root_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end

  def after_update_path_for(resource)
    question_path(resource)
  end
end
