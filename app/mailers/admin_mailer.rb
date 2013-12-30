class AdminMailer < ActionMailer::Base
  default from: "from@example.com"

  def admin_mail(user,sub,msg)
    @user = user
    @message=msg
    mail(:to => user, :subject => sub)
  end
end
