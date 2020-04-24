class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: %i[index]
  before_action :correct_user, only: %i[edit update]
  before_action :question_set, only: %i[edit update show destroy]

  def new
    @question = Question.new
  end

  def create
    @question = current_user.questions.build(question_params)
    if @question.save
      flash[:success] = '質問が保存されました'
      redirect_to questions_path, method: :get
    else
      render :new
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      flash[:success] = '質問を更新しました'
      redirect_to question_path
    else
      render :edit
    end
  end

  def index
    @questions = Question.all
  end

  def show; end

  def destroy
    if current_user == @question.user
      @question.destroy
      flash[:success] = '質問が削除されました'
      redirect_to questions_path method: :get
    else
      flash[:danger] = '権限がありません'
      redirect_to root_url
    end
  end

  def user_question
    @questions = current_user.questions
  end

  def user_favorite
    @questions = current_user.favorite_questions.includes(:user).all
  end

  private

  def question_params
    params.require(:question).permit(:title, :content, :image)
  end

  def question_set
    @question = Question.find(params[:id])
  end

  def correct_user
    @question = current_user.questions.find_by(id: params[:id])
    return unless @question.nil?

    redirect_to root_path
    flash[:danger] = '権限がありません'
  end
end
