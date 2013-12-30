class AdminMailer < ActionMailer::Base
  default from: "from@example.com"

  def admin_mail(user)
    @user = user
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Registered")
  end
end
