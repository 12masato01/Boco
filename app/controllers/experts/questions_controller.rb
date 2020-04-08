class Experts::QuestionsController < ApplicationController
before_action :authenticate_expert!

  def index
    @questions = Question.all
  end

  def show
    @question = Question.find(params[:id])
  end
end