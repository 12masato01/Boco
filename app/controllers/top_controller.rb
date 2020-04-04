# frozen_string_literal: true

class TopController < ApplicationController
  def home
    @questions = Question.limit(3)
  end

  def user_question
    @questions = current_user.questions
  end
end
