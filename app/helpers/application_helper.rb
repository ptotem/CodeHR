module ApplicationHelper

  def custom_lable(object, attribute)
    if object.class.validators_on(attribute).map(&:class).include? Mongoid::Validations::PresenceValidator
      "<lable class='control-label'>"+attribute.to_s.gsub!('_',' ').titleize+" <span style='color:red;'>*</span></lable>"
    else
      "<lable class='control-label'>"+attribute.to_s.titleize+"</lable>"
    end
  end

  def step_processing(oclass,oaction,action_to,content,pid,stepno,user_id)
    #redirect_to "/roles/new"
    #Todo create a switch case based on different type of action
    case oaction
      when "Creation"
        @user=User.find(user_id)
        @user.current_redirect_url="/#{oclass.downcase}_#{oaction.downcase}/#{pid}/#{stepno}"
        @user.save
        #redirect_to("/power_admin")
      when "Updation"
        @user=User.find(user_id)
        @user.current_redirect_url="/#{oclass.downcase}_#{oaction.downcase}/#{action_to}/#{pid}/#{stepno}"
        @user.save
      when "Deletion"
        @user=User.find(user_id)
        @user.current_redirect_url="/#{oclass.downcase}_#{oaction.downcase}/#{action_to}/#{pid}/#{stepno}"
        @user.save
        puts "In deletion"
      when "Notify"
        #Todo sending notification to user
        puts "To see whether it is coming or not....."
        puts action_to

        case action_to
          when "Admin"
            puts "In admin"
            @user=User.find(user_id)
            puts "Admin Found.."
            unm=@user.notification_masters.build title:"System Notification" , description:content,  type:"test1"
            unm.save
            unm.notification_details.build(:notification_master_id => unm._id,:event=>content)
            unm.email_details.build(:notification_master_id => unm._id,:event=>content)
            unm.save
            @user.save
            AdminMailer.admin_mail(@user.email,"#{oclass} #{oaction}","#{content}").deliver
            puts "Mail to admin is delivered"
            @pro=ProcessTr.find(pid)
            @pro.step_trs[stepno].end_processing_step
          when "Client"
            @pro=ProcessTr.find(pid)
            if @pro.step_trs[0].action_to.blank?
              @group=eval(oclass).where(:process_id=>pid).first
            else
              @group=eval(oclass).find(@pro.step_trs[0].action_to)
            end

            @client=@group.company_master.client
            unm=@client.notification_masters.build title:"System Notification" , description:content,  type:"test1"
            unm.save
            unm.notification_details.build(:notification_master_id => unm._id,:event=>content)
            unm.email_details.build(:notification_master_id => unm._id,:event=>content)
            unm.save
            @client.save
            AdminMailer.admin_mail(@client.email,"#{oclass} #{oaction}","#{content}").deliver
            puts "Client mail delivered"
            @pro.step_trs[stepno].end_processing_step
          when "PowerUser"
            @pro=ProcessTr.find(pid)
            if @pro.step_trs[0].action_to.blank?
              @group=eval(oclass).where(:process_id=>pid).first
            else
              @group=eval(oclass).find(@pro.step_trs[0].action_to)
            end

            @client=@group.company_master.client
            @power_users=@client.admin_users
            @power_users.each do |client|
              unm=client.notification_masters.build title:"System Notification" , description:content,  type:"test1"
              unm.save
              unm.notification_details.build(:notification_master_id => unm._id,:event=>content)
              unm.email_details.build(:notification_master_id => unm._id,:event=>content)
              unm.save
              AdminMailer.admin_mail(client.email,"#{oclass} #{oaction}","#{content}").deliver
            end
            puts "Mail to power user delivered"
            @pro.step_trs[stepno].end_processing_step
          when "Manager"
            @pro=ProcessTr.find(pid)
            @a=@pro.chits.where(:name=>"Manager").first
            @manager=eval(@a.ocname).find(@a.oid)
            @pro.step_trs[stepno].end_processing_step
          when "Array"
            puts "To be done"
        end
      when "Tagging"
        @user=User.find(user_id)
        @pro=ProcessTr.find(pid)
        @chit=@pro.chits.where(:name=>"User").first
        @user.current_redirect_url="/#{oclass.downcase}_#{oaction.downcase}_#{action_to.downcase}/#{@chit.oid}/#{pid}/#{stepno}"
        @user.save
        puts "Process is in Tagging....."


    end

  end


end
