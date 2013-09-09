class Operator::PasswordResetsController < ApplicationController
  layout 'operator/application-narrow'

  def new
    @title = t('views.operator.password_resets.actions.new.title')
  end

  def create
    operator = Operator.find_by_email(params[:email])
    operator.send_password_reset if operator
    flash[:success] = "Email sent with password reset instructions."
    redirect_to operator_login_path
  end

  def edit
    @title = t('views.operator.password_resets.actions.edit.title')
    @operator = Operator.find_by_password_reset_token!(params[:id])
  end

  def update
    @operator = Operator.find_by_password_reset_token!(params[:id])
    if @operator.password_reset_sent_at < 2.hours.ago
      flash[:danger] = "Password reset has expired."
      redirect_to new_operator_password_reset_path
    elsif @operator.update_attributes(operator_params)
      flash[:success] = "Password has been reset!"
      redirect_to operator_login_path
    else
      @title = t('views.operator.password_resets.actions.edit.title')
      render :edit
    end
  end

  private

  def operator_params
    params.require(:operator).permit(:password, :password_confirmation)
  end
end
