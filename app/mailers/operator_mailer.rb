class OperatorMailer < ActionMailer::Base
  default from: "from@example.com"

  def password_reset(operator)
    @operator = operator
    mail to: operator.email, subject: "Password Reset"
  end
end
