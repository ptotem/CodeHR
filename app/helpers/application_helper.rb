module ApplicationHelper
  def step_processing(oclass,oaction,action_to,content,pid,stepno,user_id)
    #redirect_to "/roles/new"
    #Todo create a switch case based on different type of action
    case oaction
      when "Creation"
        @user=User.find(user_id)
        @user.current_redirect_url="/role_creation/#{pid}/#{stepno}"
        @user.save
      when "Updation"
        @user=User.find(user_id)
        @user.current_redirect_url="/role_updation/#{action_to}/#{pid}/#{stepno}"
        @user.save
      when "Deletion"
        @user=User.find(user_id)
        @user.current_redirect_url="/role_deletion/#{action_to}/#{pid}/#{stepno}"
        @user.save
        puts "In deletion"
      when "Notify"
        #Todo sending notification to user
        case action_to
          when "Admin"
            @user=User.find(user_id)
            unm=@user.notification_masters.build title:"System Notification" , description:content,  type:"test1"
            unm.save
            unm.notification_details.build(:notification_master_id => unm._id,:event=>content)
            unm.email_details.build(:notification_master_id => unm._id,:event=>content)
            unm.save
            @user.save
          when "Client"
          when "PowerUser"
        end

        AdminMailer.admin_mail(@user.email,"#{oclass} #{oaction}","#{content}")
        @pro=ProcessTr.find(pid)
        @pro.step_trs[stepno].end_processing_step
    end

  end


end
