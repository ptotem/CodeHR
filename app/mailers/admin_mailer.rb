class AdminMailer < ActionMailer::Base
   default from: "Code HR"

  def admin_mail(user,sub,msg)
    @user = user
    @message=msg
    @employee_master= EmployeeMaster.last
    puts @employee_master
    mail(:to => "sunny@ptotem.com", :subject => "sub")
  end

  def show_mail(user,sub,msg,oclass,oid,link1,link2)
    @user=user
    @message = msg
    @data=eval(oclass).find(oid)
    @link1 = link1
    @link2 = link2
    #puts @link1
    #puts @link2
    #@oid=oid
    mail(:to=>user, :subject => sub)
  end

  def show_mail1(user,sub,msg,data,link1,link2)
    @user=user
    @message = msg
    @data=data
    @link1 = link1
    @link2 = link2

    puts @data['_id']
    mail(:to=>user, :subject => sub)
  end

  def send_mail_with_attachment(user,sub,msg,filename,filepath,link1,link2)
    @user=user
    @message = msg
    @filename=filename
    @filepath=filepath
    @link1 = link1
    @link2 = link2
    attachments[filename] = File.read(filepath)
    mail(:to=>user, :subject => sub)
  end
end
