# frozen_string_literal: true

class TopController < ApplicationController
  def home
    @questions = Question.limit(3)
  end
end
