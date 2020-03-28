# frozen_string_literal: true

class TopController < ApplicationController
  def home
    @questions = Question.all
  end
end
