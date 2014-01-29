module ApplicationHelper

  def custom_lable(object, attribute)
    if object.class.validators_on(attribute).map(&:class).include? Mongoid::Validations::PresenceValidator
      "<lable class='control-label'>"+attribute.to_s.gsub!('_',' ').titleize+" <span style='color:red;'>*</span></lable>"
    else
      "<lable class='control-label'>"+attribute.to_s.titleize+"</lable>"
    end
  end

  def step_processing(oclass,oaction,action_to,content,pid,stepno,user_id)
    #todo: Making it more generic making a function for for the actions which are repeating itself in different controller
    #todo: Making routing dynamic and generic

    case oaction
      when "Creation"
        @user=User.find(user_id)
        @user.current_redirect_url="/creation/#{oclass}/#{pid}/#{stepno}"
        @user.save
      when "Updation"
        @user=User.find(user_id)
        @user.current_redirect_url="/updation/#{oclass}/#{action_to}/#{pid}/#{stepno}"
        @user.save
      when "Deletion"
        @user=User.find(user_id)
        @user.current_redirect_url="/deletion/#{oclass}/#{action_to}/#{pid}/#{stepno}"
        @user.save
        puts "In deletion"
      when "Notify"
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
            @manager=eval(@a.ocname).find(@a.oid).user
            puts @manager
            unm=@manager.notification_masters.build title:"System Notification" , description:content,  type:"test1"
            unm.save
            unm.notification_details.build(:notification_master_id => unm._id,:event=>content)
            unm.email_details.build(:notification_master_id => unm._id,:event=>content)
            unm.save
            @manager.save
            AdminMailer.admin_mail(@manager.email,"#{oclass} #{oaction}","#{content}").deliver
            puts "Mail to admin is delivered"
            @pro.step_trs[stepno].end_processing_step
          when "Array"
            puts "To be done"
            @pro=ProcessTr.find(pid)
            @action_arrs=@pro.step_trs[stepno].action_arrs
            #to get the array data and send them notification
            puts "Got the data"
            @action_arrs.each do |aarr|
              @user=eval(aarr.a_cls_name).find(aarr.obj_id).user
              unm=@user.notification_masters.build title:"System Notification" , description:content,  type:"test1"
              unm.save
              unm.notification_details.build(:notification_master_id => unm._id,:event=>content)
              unm.email_details.build(:notification_master_id => unm._id,:event=>content)
              unm.save
              @user.save
              AdminMailer.admin_mail(@user.email,"#{oclass} #{oaction}","#{content}").deliver
              puts "Mail to admin is delivered"
            end
            @pro.step_trs[stepno].end_processing_step
          when "User"
            @pro=ProcessTr.find(pid)
            @user=EmployeeMaster.find(@pro.chits.where(:name=>"User").first.oid).user
            unm=@user.notification_masters.build title:"System Notification" , description:content,  type:"test1"
            unm.save
            unm.notification_details.build(:notification_master_id => unm._id,:event=>content)
            unm.email_details.build(:notification_master_id => unm._id,:event=>content)
            unm.save
            @user.save
            AdminMailer.admin_mail(@user.email,"#{oclass} #{oaction}","#{content}").deliver
            puts "Mail to User is delivered"
            @pro=ProcessTr.find(pid)
            @pro.step_trs[stepno].end_processing_step
            puts "This was the last step of the process..."

        end
      when "Tagging"
        @user=User.find(user_id)
        @pro=ProcessTr.find(pid)
        @chit=@pro.chits.where(:name=>"User").first
        @user.current_redirect_url="/#{oclass.downcase}_#{oaction.downcase}_#{action_to.downcase}/#{@chit.oid}/#{pid}/#{stepno}"
        @user.save
        puts "Process is in Tagging....."
      when "Approval"
        @pro=ProcessTr.find(pid)
        puts "Current Process is in approval stage"
        puts "Sending approval request to People."
        @step=@pro.step_trs[stepno]
        @app=ApprovalMat.create!(:name=>@pro.name,:description=>content,:link=>'',:complete=>false,:process_tr_id=>@pro._id,:step_no=>stepno,:approved_next_step=> @step.approved_next_step,:reject_next_step=> @step.reject_next_step,:reminder=> @step.reminder,:rep_reminder=> @step.rep_reminder ,:escalate=> @step.escalate ,:rep_escalate=> @step.rep_escalate,:auto_assign=> @step.auto_assign)
        link="http://codehr.in/#{oclass.downcase}_#{oaction.downcase}/#{@pro.chits.first.oid}/#{@pro._id}/#{stepno}/#{@app._id}"
        @app.link=link
        @app.save
        @step.action_arrs.each do |aa|
          if aa.dep_clas_name.blank?
            @app.approvers.create!(:employee_master_id=>aa.obj_id,:approved=>false,:escalated=>false,:escalated_from=>nil,:active=>true)
          else
            @grps=EmployeeMaster.where(aa.dep_clas_name.to_sym => aa.obj_id)
            @grps.each do |grp|
              @app.approvers.create!(:employee_master_id=>grp._id,:approved=>false,:escalated=>false,:escalated_from=>nil,:active=>true)
            end
          end
        end
        @step.auto_assign_to_trs.each do |aa|
          if aa.dclass.blank?
            @app.approvers.create!(:employee_master_id=>aa.objid,:approved=>false,:escalated=>true,:escalated_from=>nil,:active=>false)
          else
            @grps=EmployeeMaster.where(aa.dclass.to_sym => aa.objid)
            @grps.each do |grp|
              @app.approvers.create!(:employee_master_id=>grp._id,:approved=>false,:escalated=>true,:escalated_from=>nil,:active=>false)
            end
          end
        end
        @app.send_notification
        puts "Approval"
      when "Release"
        puts "Process in release stage..."
        @pro=ProcessTr.find(pid)
        @user=User.find(user_id)
        @user.current_redirect_url="/#{oclass.downcase}_#{oaction.downcase}/#{@pro.chits.first._id}/#{pid}/#{stepno}"
        @user.save
      when "Completed"
        puts "Process in system completetion stage"
        @pro=ProcessTr.find(pid)
        @pro.step_trs[stepno].end_processing_step
        puts "Process is completed."
      when "Checkstate"
        puts "System in check state"
        @pro=ProcessTr.find(pid)
        @pro.step_trs[stepno].end_processing_step
        #@obj=@pro.chits
      when "Loop"
        #System in the loop"
        puts "Loop Started"
        @pro=ProcessTr.find(pid)
        @pro.step_trs[stepno].end_processing_step
      when "EndLoop"
        puts "Reached Loop End"
        @pro=ProcessTr.find(pid)
        #if false
          @pro.step_trs[@pro.step_trs.find(@pro.loop_step).index..step_no].map{|i| i.state="created"}
          @pro.save
          @pro.step_trs[@pro.step_trs.find(@pro.loop_step).index].initialise_step
        #else
          @pro.step_trs[stepno].end_processing_step
        #end
    end

  end

  def check_state

  end


end
