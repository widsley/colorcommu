#coding: utf-8
class Operator::OperatorController < ApplicationController
  before_action :authenticate_operator
  layout 'operator/application'

  private

  def current_operator
    @current_operator ||= Operator.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end

  helper_method :current_operator

  def authenticate_operator
    if current_operator.nil?
      store_target_location
      flash[:danger] = 'ログインしてください。'
      redirect_to operator_login_path
    end
  end
end