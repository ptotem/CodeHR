class AdminMailer < ActionMailer::Base
  default from: "from@example.com"

  def admin_mail(user,sub,msg)
    @user = user
    @message=msg
    @employee_master= EmployeeMaster.last
    #puts @employee_master
    mail(:to => user, :subject => sub,)
  end

  def show_mail(user,sub,msg,oclass,oid,link1,link2)
    @user=user
    @message = msg
    @data=eval(oclass).find(oid)
    @link1 = link1
    @link2 = link2
    #@oid=oid
    mail(:to=>user, :subject => sub)
  end
end
