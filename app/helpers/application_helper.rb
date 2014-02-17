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
        @chit=@pro.chits.first
        @user.current_redirect_url="/#{oclass.downcase}_#{oaction.downcase}_#{action_to.downcase}/#{@chit.oid}/#{pid}/#{stepno}"
        @user.save
        puts "Process is in Tagging....."
      when "Approval"
        @pro=ProcessTr.find(pid)
        puts "Current Process is in approval stage"
        puts "Sending approval request to People."
        @step=@pro.step_trs[stepno]
        @app=ApprovalMat.create!(:name=>@pro.name,ocls:oclass,oid:@pro.chits.first.oid,:description=>content,:link=>'',:complete=>false,:process_tr_id=>@pro._id,:step_no=>stepno,:approved_next_step=> @step.approved_next_step,:reject_next_step=> @step.reject_next_step,:reminder=> @step.reminder,:rep_reminder=> @step.rep_reminder ,:escalate=> @step.escalate ,:rep_escalate=> @step.rep_escalate,:auto_assign=> @step.auto_assign)
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
        #todo: Add redirection url and task

        @user=User.find(user_id)
        @user.user_tasks.create!(:user_id=>user_id,title:"Confirm or change approval request",description:"Visit this link to send approval",link:"/updation/ApprovalMat/#{@app._id}/#{@pro._id}/#{stepno}",seen:false)
        @user.current_redirect_url="/approval_updation/#{@app._id}/#{@pro._id}/#{stepno}"
        @user.save
        puts "Approval"
      when "Release"
        puts "Process in release stage..."
        @pro=ProcessTr.find(pid)
        @user=User.find(user_id)
        a="/#{oclass.downcase}_#{oaction.downcase}/#{@pro.chits.first.oid}/#{pid}/#{stepno}"
        @user.user_tasks.create!(:user_id=>user_id,title:"Release #{oclass}",description:"Visit this link to release <a href="+a+"></a>")
        @user.current_redirect_url=a
        @user.save
      when "Completed"
        puts "Process in system completetion stage"
        @pro=ProcessTr.find(pid)
        @pro.step_trs[stepno].end_processing_step
        puts "Process is completed."
      when "CheckState"
        puts "System in check state"
        @pro=ProcessTr.find(pid)
        @pro.step_trs[stepno].end_processing_step
        #@obj=@pro.chits
      when "Loop"
        #System in the loop"
        puts "Loop Started"
        @pro=ProcessTr.find(pid)
        @pro.step_trs[stepno].end_processing_step
        @pro.loop_step= stepno
        @pro.save
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

  #todo:Building a totally new function to handle automatic processes
  def step_transaction_processing(action_name,oclass,objid,pid,stepno,user_id,*args)
    puts action_name
    puts oclass
    puts objid
    puts args
    case action_name
      when "Fill"
        puts "Inside Fill form step of the current process"
        @user=User.find(user_id)
        @user.user_tasks.create!(:user_id=>user_id,title:"Fill #{oclass} form",description:"Visit this link to fill #{oclass} form",link:"/fillform/#{oclass}/#{pid}/#{stepno}",seen:false)
        @user.current_redirect_url="/fillform/#{oclass}/#{pid}/#{stepno}"
        @user.save
      when "Update"
        puts "Inside update form step of the current process"
        #todo:The same function as fill shoulod br written her with passing thge object id as parameter
        @user = User.find(user_id)
        @user.user_tasks.create!(:user_id=>user_id,title:"Fill #{oclass} form",description:"Visit this link to fill #{oclass} form",link:"/fillform/#{oclass}/#{pid}/#{stepno}",seen:false)
        @user.current_redirect_url="/updaetform/#{oclass}/#{objid}/#{pid}/#{stepno}"
        @user.save
      when "Approve"
        puts "In side approval"
        @pro = ProcessTransact.find(pid)
        @step=@pro.step_transacts[stepno]
        @app=ApprovalMat.create!(:name=>@pro.name,ocls:oclass,oid:"",:description=>"Please approve or reject this step",:link=>'',:complete=>false,:process_tr_id=>@pro._id,:step_no=>stepno,:approved_next_step=> "",:reject_next_step=> "",:reminder=> @pro.app_obj["reminder"],:rep_reminder=> @pro.app_obj["rep_reminder"] ,:escalate=> @pro.app_obj["escalate"] ,:rep_escalate=> "",:auto_assign=> @pro.app_obj["auto_assign"])
        #toDo: Making the link for approval page
        #link="http://codehr.in/#{oclass.downcase}_#{oaction.downcase}/#{@pro.chits.first.oid}/#{@pro._id}/#{stepno}/#{@app._id}"
        #@app.link=link
        @app.save
        #index = 0
        @pro.app_obj["approvers"].each do |k,a|
          #puts "uuuu"
          #puts @pro.app_obj["approvers"][k]
          #puts a
          if a["oClass"] == "EmployeeMaster"
            a["action_arr"].each do |aaa|
              @app.approvers.create!(:employee_master_id=>aaa,:approved=>false,:escalated=>false,:escalated_from=>nil,:active=>true)
            end
          else
            puts "Todo"
          end
          #index=index+1
        end
        @app.send_notification
        puts "Approval"
        puts "Inside Approval step of the current process"
      when "Notify"
        puts "Notifying"
        @pro = ProcessTransact.find(pid)
        @pro.notification_obj["action_arr"].each do |noti|
          puts noti
          puts "noti"
          @user=EmployeeMaster.find(noti).user
          puts @user
          unm=@user.notification_masters.build title:"System Notification" , description:"Notification Description",  type:"test1", read: false
          unm.save
          unm.notification_details.build(:notification_master_id => unm._id,:event=>"Info")
          unm.email_details.build(:notification_master_id => unm._id,:event=>"Info")
          unm.save
          @user.save
        end
        @pro.step_transacts[stepno].end_processing_step
      when "MarkComplete"
        puts "Mark Complete Code goes here."
        @pro = ProcessTransact.find(pid)
        @step=@pro.step_transacts[stepno]
        #todo:Creating the class object with parameter
        #eval(oclass).new(@pro.class_obj))
        #eval(oclass).save
        @pro.step_transacts[stepno].end_processing_step
      when "SpawnD"
        puts "Calling a new process dependently.."
        @pro = ProcessTransact.find(pid)
        @step=@pro.step_transacts[stepno]
        if @step.auto
        #  TODO:
        #  create_and_load_process(pid,step_no,oclass,user_id,true)
        else
        #  TODO: Create a new Process and initiate it.
          #create new Process
          create_and_load_process(pid,stepno,oclass,user_id,true)
        end
      when "SpawnI"
        puts "Calling a new process independently.."
        @pro = ProcessTransact.find(pid)
        @step=@pro.step_transacts[stepno]
        if @step.auto
          #  TODO:
          #  create_and_load_process(pid,step_no,oclass,user_id,false)
        else
          #  TODO: Create a new Process and initiate it.
          #create new Process
          create_and_load_process(pid,stepno,objid,user_id,false)
        end
        @pro.step_transacts[stepno].end_processing_step
    end
  end

  def check_state

  end

  def create_and_load_process(parent_process_id, parent_step_no, pid,userid,dependent)
    @mp=MasterPro.find(pid)
    @process_transact = ProcessTransact.create!(:dependent=>dependent,:created_by_process=>true,:parent_pro_id=>parent_process_id,:parent_step_no=>parent_step_no,:name => "Child process", :created_by => userid, :facilitated_by => userid, :user_id =>userid)
    @mp.master_steps.each do |sm|
      @step_transact = @process_transact.step_transacts.build(:name => sm.step_name,:action_name=> sm.action,:action_object_id=>"",:obj_name => sm.action_class)
    end
    @process_transact.load_process
    #@new_process = ProcessTransact.create!()
  end


end
