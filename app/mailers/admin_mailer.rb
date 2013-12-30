class AdminMailer < ActionMailer::Base
  default from: "from@example.com"

  def admin_mail(user)
    @user = user
    mail(:to => user, :subject => "Registered")
  end
end
