class Operator::SessionsController < ApplicationController
  layout 'operator/login'

  def new
    @title = t('views.operator.sessions.actions.new.title')
  end

  def create
    operator = Operator.find_by_username(params[:username])
    if operator && operator.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:auth_token] = operator.auth_token
      else
        cookies[:auth_token] = operator.auth_token
      end

      flash[:success] = t('activerecord.flash.session.actions.create.success')
      #redirect_to operator_root_path
      redirect_to_target_or_default operator_root_path
    else
      @title = t('views.operator.sessions.actions.new.title')
      flash[:danger] = t('activerecord.flash.session.actions.create.failure')
      render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    flash[:success] = t('activerecord.flash.session.actions.destroy.success')
    redirect_to operator_login_path
  end
end
