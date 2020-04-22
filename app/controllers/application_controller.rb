class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_serch
  helper_method :user_info

  def user_info(user_id)
    User.find(user_id)
  end

  def set_serch
    @q = Question.ransack(params[:q])
    @search_questions = @q.result(distinct: true)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
