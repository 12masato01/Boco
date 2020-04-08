# frozen_string_literal: true
before_action :authenticate_admin!, only: [:user_index]

class TopController < ApplicationController
  def home
    @questions = Question.limit(3)
  end

  def user_question
    @questions = current_user.questions
  end

  def user_index
    @users = User.all
  end
end
